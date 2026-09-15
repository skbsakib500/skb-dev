# SKB Navigation Contract v1

---

## 1. State Shape

Every navigable screen may carry:

    {
      "route":    "finance.transactions",     // dotted id
      "params":   { "month": "2026-09" },     // identity
      "scroll":   { "y": 842, "itemId": 42 }, // position
      "tabs":     { "selected": "expense" },  // tab state
      "filters":  { "range": "month", "type": "expense" },
      "search":   { "query": "" },
      "sort":     { "by": "newest" },
      "form":     { "dirty": false, "data": {} },
      "ts":       "2026-09-16T02:50:00Z"      // for expiry
    }

Canonical shape: `state.schema.json`

**Rule:** Adapters may add keys, must not remove required keys.

---

## 2. Route Registry

Every app declares its routes in `routes.json`:

    {
      "schema": "skb/nav-routes/v1",
      "routes": [
        {
          "id": "finance.transactions",
          "parent": "finance",
          "restorable": true,
          "guard": "unsaved",
          "dedupe": true
        }
      ]
    }

Fields:
- `id` — dotted, unique
- `parent` — for back-hierarchy fallback
- `restorable` — can state be persisted across process death?
- `guard` — "none" | "unsaved" | "confirm"
- `dedupe` — prevent duplicate entries in stack

---

## 3. Back Priority Algorithm

When user presses Back, evaluate **in order**:

    1. Modal / sheet open       → close modal (return true)
    2. Keyboard open            → dismiss keyboard
    3. Form dirty + guard       → show confirm dialog
    4. Nested screen            → restore parent + its state
    5. Stack depth > 1          → pop + restore previous state
    6. Stack depth == 1 (root)  → emit NAV_EXIT_REQUEST
                                   → app decides (confirm / exit)

**Never** clear stack in one step unless explicitly requested
(`NAV_RESET` event).

---

## 4. Universal Events

Every navigation action emits exactly one event:

| Event | When |
|-------|------|
| `NAV_PUSH` | new route pushed |
| `NAV_POP` | route popped (back) |
| `NAV_REPLACE` | current route replaced |
| `NAV_RESET` | stack cleared to root |
| `NAV_RESTORE` | state restored (process death) |
| `NAV_DEEP_LINK` | opened from `skb://` URL |
| `NAV_RESUME` | foreground after background |

Payload for every event: `{ event, route, params, prevRoute, prevParams, ts }`

Canonical shape: `events.schema.json`

---

## 5. Deep Link Scheme

    skb://<app>/<route-path>?<params>

Examples:
    skb://mimi/finance/transactions?month=2026-09
    skb://music/playlist/42
    skb://player/video/123?t=45

**v1:** app-internal deep links only.
**v2:** cross-app routing (SKB-Core resolves intent).

---

## 6. Persistence Rules

State persistence has **3 tiers**:

| Tier | Storage | Lifetime | Restorable |
|------|---------|----------|:---:|
| **Ephemeral** | RAM (stack) | session | no |
| **Session** | `sessionStorage` | until app killed | yes |
| **Durable** | `localStorage` / SQLite | until cleared | yes |

**Rule:** Only routes with `restorable: true` write to Session or Durable.
Root stack always written to Session (for `NAV_RESTORE`).

**Expiry:** State older than 7 days is dropped on restore.

---

## 7. Navigation Guards

Guard types:

- `none` — allow nav
- `unsaved` — warn on leaving if `form.dirty == true`
- `confirm` — always ask

Guard UI:
    "Discard changes?"
    [Cancel]  [Discard]

**Rule:** Guard fires only once per back press.
No guard chaining (no dialog → dialog → dialog).

---

## 8. Route Deduplication

When pushing a route with `dedupe: true`:

- If same `route + params` exists earlier in stack → pop to it
  (rather than push duplicate)
- If params differ → treat as new

Bad:  Home → Finance → Finance → Finance
Good: Home → Finance → Transactions

---

## 9. Adapter Expectations

Every runtime adapter **must**:

- Load route registry from `routes.json` (or app's mirror)
- Emit all 7 universal events
- Implement back priority algorithm
- Persist per persistence rules
- Respect guards
- Dedupe per config
- **Never** mutate spec/ files

Adapter **may**:
- Add runtime-specific keys to state (prefixed with `_` or `_app_`)
- Use framework-native transitions
- Defer restore if async data loading is needed

---

## 10. Out-of-Scope (v2)

- Cross-app `skb://` resolution
- AI intent routing
- Predictive back gesture
- Navigation search UI
- Adaptive navigation (tablet/desktop)
- Breadcrumbs

---

_Last updated: 2026-09-16_
