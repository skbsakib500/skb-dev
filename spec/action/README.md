# SKB Action Contract

**Version:** v1 (locked 2026-09-16)
**Layer:** L0 — Foundation
**Consumed by:** Design System · Interaction Engine · Undo/Redo ·
Offline/Sync · Testing · Search

---

## Purpose

Every mutation across SKB apps goes through **one contract**:
create, update, delete, search, export, etc.

No more "some tools call `save-to-notes`, others call `create`,
others just write to Store directly."

One vocabulary → one event stream → undo/redo/sync/audit possible.

## Non-Goals

- Business logic (adapters implement)
- Storage choice (SQLite, localStorage — adapter's call)
- UI presentation
- Network transport

## Architecture

    spec/action/                ← this (canonical)
    ├── CONTRACT.md
    ├── actions.schema.json
    └── routes.json             per-app registry template

    Runtime adapters:
    ├── Mimi-Android → core/actions.js   (reference)
    ├── Agent-Mimi   → mimi/actions.py   (future)
    └── ...

## Golden rule

> **An action is data. Data can be logged, undone, synced, tested.**
> **A function call is not.**

## Version

- v1 — 2026-09-16 — initial lock
