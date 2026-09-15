# SKB Schema v1

> The `.skb/` contract every SKB project must honor.
> **Locked 2026-09-16.** Breaking changes require `schema: skb/v2`.

## Files (all live in `<project>/.skb/`)

| File | Purpose | Mutability |
|------|---------|------------|
| `project.json` | Identity — who, what, where | rarely |
| `state.json` | Current snapshot | frequently |
| `history.json` | Timeline — releases, milestones, events | append-only |
| `config.json` | Per-project behavior | rarely |
| `modules.json` | Module registry | on module change |
| `assets.json` | Asset registry | on asset change |

Every file MUST include `"schema": "skb/v1"`.

## project.json — fields

| Field | Type | Purpose |
|-------|------|---------|
| `schema` | string | Always `"skb/v1"` |
| `id` | string | Globally unique. Format: `skb-<name>` |
| `name` | string | Human display name |
| `type` | enum | `android-app` `python-app` `cli-tool` `web-app` `library` |
| `subtype` | string | Free-text refinement (optional) |
| `version` | semver | Current version |
| `status` | enum | `active` `paused` `archived` |
| `author` | object | `name`, `email`, `github` |
| `repo` | object | `remote`, `branch` |
| `stack` | array | Tech stack entries |
| `companions` | array | Related project IDs |
| `created` | date | ISO 8601 |
| `last_touched` | date | ISO 8601 |

## state.json — fields

| Field | Type | Purpose |
|-------|------|---------|
| `current_focus` | string | One-line: what you are doing now |
| `next_focus` | string | One-line: what comes next |
| `progress` | int 0-100 | Rough % through current phase |
| `build` | enum | `unknown` `ready` `broken` |
| `tests` | enum | `unknown` `passing` `failing` `none` |
| `git` | object | Snapshot of git state (see template) |
| `known_issues_open` | array | IDs of open issues |

## history.json — fields

Three append-only arrays:

- `releases[]` — one entry per tagged release
- `milestones[]` — named progress markers
- `events[]` — notable events (security incidents, big refactors)

Never edit existing entries. Never delete.

## config.json — fields

Per-project behavior:

- `default_branch` — usually `main`
- `release.*` — release workflow settings
- `context.*` — what Context Engine includes
- `security.*` — secret-scan patterns
- `notifications.*` — event hooks

## modules.json — fields

Each module:

| Field | Type | Purpose |
|-------|------|---------|
| `name` | string | Short id |
| `path` | string | File or directory |
| `type` | enum | see template |
| `role` | string | One-line purpose |
| `status` | enum | `active` `planned` `deprecated` |
| `dependencies` | array | Other module names |

## assets.json — fields

Each asset:

| Field | Type | Purpose |
|-------|------|---------|
| `type` | enum | see template |
| `path` | string | File or glob |
| `purpose` | string | Why it exists |
| `version` | string | Optional |

## Validation rules

`skb doctor` will enforce:

1. Every `.skb/*.json` has `"schema": "skb/v1"`.
2. All required fields present.
3. No secrets in any `.skb/` file.
4. `history.json` never shrinks (compare against git).
5. `state.git.head` matches actual git HEAD.

## Versioning

- `skb/v1` — locked 2026-09-16
- Breaking changes → `skb/v2` (migration script required)

## Migration policy

When v2 ships:

1. `skb migrate <project>` reads v1, writes v2.
2. Original v1 files backed up to `.skb.backup.v1/`.
3. Manual review before commit.
