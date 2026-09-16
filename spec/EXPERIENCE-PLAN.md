# SKB Universal Experience Layer — Master Plan

**Version:** v1 (locked 2026-09-16)
**Status:** Planning — Phase 12 in progress
**Scope:** All SKB apps (Mimi-Android, SKB-Player, SKB-Music, future)

---

## Purpose

Define the **dependency order** and **ownership rules** for 15
ecosystem-wide systems. Not runtime code — this is a map.

Without this map: 15 systems become 15 divergent half-implementations.
With this map: 15 systems become 1 coherent platform.

---

## The 15 Systems

| # | System | Layer | Status |
|---|--------|:---:|:---:|
| 3 | Universal State | L0 | planned |
| 12 | Command/Action | L0 | **Phase 12 (now)** |
| 1 | Design Tokens | L0 | planned |
| 1b | Design System (impl) | L1 | planned |
| 2 | Interaction Engine | L1 | partial |
| 13 | Undo/Redo | L1 | planned |
| 6 | Offline-First | L2 | planned |
| 7 | Sync Engine | L2 | partial (bridge) |
| 5 | Notification Intelligence | L2 | partial (raw) |
| 8 | Security / Privacy | L3 | partial (skb guard) |
| 9 | Accessibility | L3 | planned |
| 10 | Performance | L3 | planned |
| 11 | Testing Contract | L3 | planned |
| 4 | Universal Search | L4 | planned |
| 14 | Export / Import | L4 | partial (bridge) |
| 15 | Doctor | cross | partial (SKB-Dev) |

---

## Layer Map

    L0  FOUNDATION (contracts — locked before code)
        ├── Universal State        (how state moves)
        ├── Command/Action         (how changes happen)
        └── Design Tokens          (how things look)

    L1  INTERACTION (consumes L0)
        ├── Design System          (implements tokens)
        ├── Interaction Engine     (tap, swipe, haptic)
        └── Undo/Redo              (replays commands)

    L2  RELIABILITY (consumes L0 + L1)
        ├── Offline-First          (queueing pattern)
        ├── Sync Engine            (canonical JSON bridge)
        └── Notification Intel     (priority + grouping)

    L3  POLICY (docs + linters — not runtime)
        ├── Security / Privacy
        ├── Accessibility
        ├── Performance budgets
        └── Testing Contract

    L4  UTILITY (consumes everything above)
        ├── Universal Search
        └── Export / Import

---

## Dependency Graph

             STATE  ──────────┐
                              │
                              ▼
                      COMMAND / ACTION ─────────┐
                              │                 │
                  ┌───────────┼───────────┐     │
                  ▼           ▼           ▼     │
              Design      Interaction   Undo    │
              System        Engine      Redo    │
                  │           │           │     │
                  └───────────┼───────────┘     │
                              ▼                 │
                        Offline / Sync ◄────────┘
                              │
                  ┌───────────┼───────────┐
                  ▼           ▼           ▼
              Security    Testing    Performance
                  │
                  ▼
           Search / Export

    DESIGN TOKENS ─── parallel to State (sibling, not child)
        reason: tokens are not state-dependent. UI consumes both.

---

## Ownership Rules

### Rule 1 — Spec owns contracts, adapter owns behavior

    spec/<system>/    ← canonical contract (git-tracked, versioned)
    <app>/core/       ← runtime adapter (implements contract)

Runtime NEVER edits spec. Spec NEVER knows about adapters.

### Rule 2 — No cross-adapter imports

    Mimi-Android/core/nav.js   ✗ imports SKB-Player/nav.kt
    Mimi-Android/core/nav.js   ✓ imports spec/nav/CONTRACT.md

Every adapter talks only to the contract, never to another adapter.

### Rule 3 — Layer order is a hard rule

An L2 system MUST NOT be implemented before its L1 dependencies.
An L0 contract MUST be locked before any L1 system that consumes it.

If you break the order, you will rewrite at the next layer.

### Rule 4 — Every layer has 4 artifacts

    spec/<system>/
        README.md            what/why
        CONTRACT.md          rules
        <name>.schema.json   shape
        routes.json          app template (if applicable)

No layer is "done" until all four exist (when applicable).

### Rule 5 — Reference adapter before other adapters

First adapter is the reference (usually Mimi-Android — WebView/JS
is easiest to verify). Only after reference passes tests does it
become a model for Kotlin/Swift/etc.

---

## Adapter Rules

Every adapter MUST:

- Load its contract (spec) — never hardcode rules
- Emit canonical events matching the schema
- Expose a public API matching the contract method names
- Fail safe (fallback if spec missing, never crash)
- Never mutate data outside its system

Every adapter MAY:

- Use framework-native primitives internally (Compose state, DOM, etc.)
- Add private helper methods (prefixed `_`)
- Cache computed values

---

## Verification Rules

Every layer requires:

1. **Unit-level test** in Node/Python sandbox (no UI)
2. **Integration test** — real app loads without console errors
3. **Cross-adapter test** — same contract, ≥2 runtimes when available
4. **Fallback test** — spec removed → graceful degradation

A layer is "done" only when all four pass.

---

## Execution Sequence (locked)

    Phase 12 — Action Contract      (L0, this phase)
    Phase 13 — State Contract       (L0)
    Phase 14 — Design Tokens        (L0, parallel)
    Phase 15 — Design System impl   (L1)
    Phase 16 — Interaction Engine   (L1)
    Phase 17 — Undo/Redo            (L1)
    Phase 18 — Offline-First        (L2)
    Phase 19 — Sync Engine          (L2)
    Phase 20 — Notification Intel   (L2)
    Phase 21 — Security Policy      (L3)
    Phase 22 — Accessibility        (L3)
    Phase 23 — Performance Budgets  (L3)
    Phase 24 — Testing Contract     (L3)
    Phase 25 — Universal Search     (L4)
    Phase 26 — Export/Import        (L4)

Order is strict. Do not skip. Do not parallelize L0 with L1.

---

## Reference Adapters (planned)

| Layer | Reference | Secondary |
|-------|-----------|-----------|
| nav | Mimi-Android `core/nav.js` ✅ | SKB-Player (future) |
| action | Mimi-Android `core/actions.js` (Phase 12) | — |
| state | Mimi-Android `core/store.js` (Phase 13) | Agent-Mimi |
| tokens | Mimi-Android `style.css` → `tokens.css` | SKB-Music (Compose) |
| ... | ... | ... |

---

## Non-Goals

This plan does NOT:

- Prescribe UI framework choice (WebView, Compose, SwiftUI — adapter's call)
- Force identical visual design across apps (same language, not same screen)
- Replace per-app business logic (domain layer stays per-app)
- Mandate cloud/network (offline-first is the default)

---

## Why This Order

    1. State + Action = the plumbing
       Without them, nothing else can be consistent.

    2. Design Tokens = the vocabulary
       Parallel to State because tokens describe form, state describes flow.

    3. Interaction + Undo = the user-visible payoff
       They depend on State + Action + Tokens.

    4. Offline + Sync = the reliability story
       Depends on State (what changed) + Action (what to replay).

    5. Policy (Security/A11y/Perf/Testing) = the trust story
       Applies to code that already exists.

    6. Search + Export = the escape hatches
       Depends on State + Action + Storage being unified.

---

## Version

- **v1** — 2026-09-16 — initial lock
- Breaking change → bump to v2, migrate adapters

---

_Last updated: 2026-09-16_
