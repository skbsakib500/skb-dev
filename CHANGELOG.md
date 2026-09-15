# Changelog — SKB-Dev

## [1.1.0] — 2026-09-16

### Added
- **Shared AI Layer** at `~/Life-OS/ai/`
- 3 runtime-agnostic prompts (daily_plan, daily_review, council_question)
- Council spec — 11 brains + protocol
- AI policies — privacy, safety, identity, boundaries, transparency, model-agnostic
- Provider routing spec (7 providers, fallback rules)
- I/O schema — standard request/response contract

### Changed
- version 1.0.0 → 1.1.0


## [1.0.0] — 2026-09-16 — "Foundation"

**First stable release.** SKB Dev Ecosystem control plane complete.

### Added
- **Schema v1** — `.skb/` contract locked (6 files per project)
- **Ecosystem registries** — aggregated views across all projects
- **Context Engine** — `skb context <p>` (human/--ai/--json)
- **Interactive dashboard** — 9-item menu
- **Security** — `skb scan`, `skb audit`, `skb guard`
- **Release Engine** — `skb release <p> <ver>` (guided, safe)
- **AI Context Export** — `skb ai-context <p>` (markdown/json)
- **Life OS registration** — `~/Life-OS/` workspace
- **Feature matrix** — `skb lifos features` (38 features × brain/android/sync)
- **Canonical schema** — `schema.json` (10 entities, v3)
- **Data Bridge** — export/validate/diff/import (canonical JSON)

### Migrated
- SKB-Dev, Agent-Mimi, Mimi-Android, SKB-Player, SKB-Music — all to Schema v1

### Design Principles
- Model-agnostic — project memory lives with the code
- No direct DB-to-DB sync — everything through canonical JSON
- Never embed secrets — enforced by guard hook
- Append-only history — never rewrite past entries
- Explicit confirmation before destructive ops

## [0.9.0] — 2026-09-16
- Life OS registered + cross-project feature matrix

## [0.8.0] — 2026-09-16
- AI Context Export (markdown/json)

## [0.7.0] — 2026-09-16
- Security: scan + audit + guard

## [0.6.0] — 2026-09-16
- Interactive Command Center

## [0.5.0] — 2026-09-16
- Context Engine

## [0.4.0] — 2026-09-16
- Ecosystem registries

## [0.3.0] — 2026-09-16
- Schema v1 dogfood


## [0.9.0] — 2026-09-16

### Added
- `skb lifos` — Life OS overview
- `skb lifos features` — cross-project feature matrix
- `skb lifos context` — AI-ready Life OS context
- `skb lifos version` — version sync check
- `~/Life-OS/` workspace (product-group registration)
- `.skb/lifos.json` — brain + delivery + vault
- `features.json` — 39 features × brain/android/sync
- `schema.json` — canonical data contract (10 entities, v3)
- `VERSION` — Life OS version lock
- `ai/` — prompts, council, policies, schemas, context (reserved)

### Changed
- version 0.8.0 → 0.9.0

## [0.8.0] — 2026-09-16

### Added
- `skb ai-context <project>` — full AI-ready export
- `--format=markdown` (default) or `--format=json`
- Includes: identity, stack, state, git, full modules, assets, issues, releases, recent commits, rules
- Model-agnostic: works with ChatGPT, Claude, Gemini, DeepSeek

### Changed
- version 0.7.0 → 0.8.0

## [0.7.0] — 2026-09-16

### Added
- `skb scan <project>` — secret scan on tracked files
- `skb scan --all` — ecosystem-wide
- `skb audit <project>` — rule compliance check
- `skb guard install` — pre-commit secret hook
- `skb guard status` / `uninstall`

### Changed
- version 0.6.0 → 0.7.0

## [0.6.0] — 2026-09-16

### Added
- Interactive dashboard menu (`skb` with no args)
- 9-item menu matching plan §11
- `skb doctor` — ecosystem health scan
- `skb dashboard` — non-interactive (scripts)
- Health checks: files, schema, secrets, git status

### Changed
- version 0.5.0 → 0.6.0

## [0.5.0] — 2026-09-16

### Added
- Context Engine (`skb context <project>`)
- 3 output modes: human, `--ai`, `--json`
- Loads from `.skb/`: project, state, history, modules, assets, config
- Live git info (head, branch, clean)
- Module type breakdown

### Changed
- version 0.4.0 → 0.5.0

## [0.4.0] — 2026-09-16

### Added
- Ecosystem registries (Phase 2)
- `registry/build.sh` — aggregator across all `.skb/` projects
- `registry/ecosystem.json` — project index
- `registry/modules.json` — all modules merged
- `registry/assets.json` — all assets merged
- `registry/schema.json` — schema version lock

### Changed
- version 0.3.0 → 0.4.0

## [0.3.0] — 2026-09-16

### Added
- SKB Schema v1 adoption (dogfood)
- .skb/ expanded from 2 → 6 files
- project.json includes companions + purpose
- state.json includes progress, build, tests
- history.json — releases, milestones, events
- config.json — release/context/security behavior
- modules.json — 14 modules (10 commands, 3 utils, 1 schema)
- assets.json — file inventory
- .gitignore

### Changed
- version 0.2.0 → 0.3.0 (schema milestone)

## [0.2.0] — 2026-09-16

### Added
- Unified command center CLI
- 9 commands: dashboard, projects, status, open, all, log, todo, issues, cd
- Reads .skb/ metadata from all projects
- Zero dependencies
