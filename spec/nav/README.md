# SKB Navigation Contract

**Version:** v1 (locked 2026-09-16)
**Applies to:** All SKB apps (Mimi-Android, SKB-Player, SKB-Music, future)
**Runtime:** Each app implements an adapter — this spec is canonical

---

## Purpose

Back should mean **"return to previous context"** — not "clear the
stack and hope for the best."

This contract defines:
- What state is preserved across navigation
- When Back restores vs when it just pops
- How session/process-death recovery works
- How deep links resolve to full context

## Non-goals

- UI framework choice (Compose, WebView, etc. — adapter's call)
- Business data ownership (domain layer keeps that)
- Visual transitions (runtime decides)
- Cross-app navigation (deferred to v2)

## Architecture

    spec/nav/               ← this (canonical)
    ├── CONTRACT.md         the standard
    ├── state.schema.json   canonical state shape
    ├── events.schema.json  7 universal events
    └── routes.json         route registry (per-app template)

    Runtime adapters:
    ├── Mimi-Android  → core/nav.js  (WebView + JS)
    ├── SKB-Player    → (future Kotlin adapter)
    └── SKB-Music     → (future Kotlin adapter)

## Golden rule

> Navigation layer **never** owns business data.
> It knows *where* and *how to restore*, not *what*.

---

## v1 Scope

| # | Feature | Status |
|---|---------|:---:|
| 1 | Canonical state shape | ✅ |
| 2 | Route registry | ✅ |
| 3 | Back priority algorithm | ✅ |
| 4 | Session + process-death persistence | ✅ |
| 5 | Universal events (7) | ✅ |
| 6 | Deep link scheme | ✅ |
| 7 | Navigation guards | ✅ |
| 8 | Route deduplication | ✅ |

## v2 (deferred)

- Cross-app deep links (`skb://` between apps)
- AI intent adapter (Mimi resolves intent → route)
- Predictive back (Android 14+)
- Navigation search (`Go to...`)
- Adaptive navigation (tablet/desktop split)
- Breadcrumbs
