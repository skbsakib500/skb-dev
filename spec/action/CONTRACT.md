# SKB Action Contract v1

---

## 1. Canonical Action Shape

Every action is an object:

    {
      "id":     "act_<timestamp>_<random>",   // unique
      "verb":   "create",                     // see §2
      "entity": "note",                       // domain noun
      "payload": { ... },                     // verb-specific
      "ts":     "2026-09-16T10:30:00.000Z",   // ISO8601
      "meta":   {
        "source":   "user" | "undo" | "redo" | "sync" | "system",
        "parentId": null | "act_...",         // if this is undo/redo
        "session":  "sess_<uuid>"             // optional
      }
    }

Canonical shape: `actions.schema.json`

**Rule:** Adapters may add fields inside `meta` (prefixed `_`),
must not remove required fields.

---

## 2. Verb Vocabulary (closed set)

Exactly 12 verbs. Adding a new verb requires spec v2.

| Verb | Meaning | Typical payload |
|------|---------|-----------------|
| `create` | insert new entity | full entity fields |
| `update` | modify existing | `{id, ...changed}` |
| `delete` | remove | `{id}` |
| `read`   | fetch one | `{id}` |
| `list`   | fetch many | `{filter?, sort?}` |
| `search` | query | `{q, scope?}` |
| `open`   | navigate/activate UI | `{route, params}` |
| `close`  | dismiss UI | `{target}` |
| `export` | serialize out | `{format, entity?, ids?}` |
| `import` | deserialize in | `{format, data}` |
| `share`  | hand off to OS | `{text?, url?, files?}` |
| `undo`   | reverse last | `{targetActionId}` |

**Rule:** If you need a verb not in this list, split it into
`create` + `update` + `open` sequence. Do not invent new verbs.

---

## 3. Entity Names

Entity = lowercase noun, singular. Examples:

    task · goal · note · transaction · debt · study · sleep
    journal · calc · video · song · playlist · setting

Domain-specific. Each app declares its entities in `routes.json`.

---

## 4. Events (emitted by adapter)

For every action, the adapter emits **exactly one** of:

| Event | When | Payload |
|-------|------|---------|
| `ACTION_REQUEST` | before handler | full action |
| `ACTION_SUCCESS` | handler returned ok | action + result |
| `ACTION_FAIL`    | handler threw / errored | action + error |

Payload shape: see `actions.schema.json`.

Undo/Redo (Phase 17) will add:
- `ACTION_UNDO` — when an action is reversed
- `ACTION_REDO` — when it is replayed

Those events are **not** in v1 scope. Adapter may reserve
subscription slots.

---

## 5. Adapter API

Every adapter MUST expose:

    register(name, fn)          legacy — register a named handler
    run(name, payload)          legacy — invoke by name
    dispatch(action)            v1 — invoke by canonical action
    list()                      registered names
    on(event, fn)               subscribe to events
    off(event, fn)              unsubscribe

`run(name, payload)` is **sugar** over `dispatch({...})` — it
constructs a minimal action from the name.

### register(name, fn)

`name` follows `verb.entity` when possible (e.g. `create.note`).
Legacy flat names (`copy`, `share`) are allowed for backward compat
but new code should use verb.entity.

### dispatch(action)

Input: canonical action (see §1).
Returns: `{ ok, result?, error? }`.
Guarantees: at least one event emitted.

### on(event, fn) / off(event, fn)

Subscribe to events listed in §4.
Handler signature: `fn(payload) -> void`.

---

## 6. Fallback

If spec file is missing or unreadable:

- Adapter MUST continue working
- Adapter MUST NOT throw
- Adapter MUST use internal defaults (built-in verbs list)
- Adapter SHOULD log a warning once

This ensures the app never breaks because spec moved.

---

## 7. Idempotency

Actions with the same `id` executed twice:
- First execution: normal
- Second execution: adapter MUST return cached result without
  re-running the handler

This is required for safe retry (offline queue, network replay).

Cache scope: sessionStorage (max 100 entries, LRU).

---

## 8. Error Contract

Errors are returned, not thrown:

    { ok: false, error: "message" }

Reasons:
- `unknown action: <name>`
- `unknown verb: <verb>`
- `missing field: <field>`
- handler exception message

The adapter does NOT throw on action failure — UI handles it.

---

## 9. Composition (future)

Chains of actions (transaction-like) are v2. For v1:
- One action = one handler
- No rollback chain
- Caller orchestrates sequences

---

## 10. Storage (adapter's choice)

The contract does NOT mandate storage.
Adapters may use: SQLite, localStorage, IndexedDB, files.

The only requirement: `read` and `list` reflect prior `create` /
`update` / `delete`.

---

_Last updated: 2026-09-16_

---

## 9. Composition (future)

Chains of actions (transaction-like) are v2. For v1:
- One action = one handler
- No rollback chain
- Caller orchestrates sequences

---

## 10. Storage (adapter's choice)

The contract does NOT mandate storage.
Adapters may use: SQLite, localStorage, IndexedDB, files.

The only requirement: `read` and `list` reflect prior `create` /
`update` / `delete`.

---

_Last updated: 2026-09-16_

---

## 9. Composition (future)

Chains of actions (transaction-like) are v2. For v1:
- One action = one handler
- No rollback chain
- Caller orchestrates sequences

---

## 10. Storage (adapter's choice)

The contract does NOT mandate storage.
Adapters may use: SQLite, localStorage, IndexedDB, files.

The only requirement: `read` and `list` reflect prior `create` /
`update` / `delete`.

---

_Last updated: 2026-09-16_
