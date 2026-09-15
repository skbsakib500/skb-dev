# Life OS Spec

Canonical, version-controlled specification for Mimi Life OS.

## Why here (not in ~/Life-OS/)
`~/Life-OS/` is a **runtime workspace** — it holds generated
exports, bridge output, and symlinks. It is not version
controlled (exports change every run, would bloat history).

This directory (`spec/lifos/`) is the **source of truth**.
Every spec file is committed and reviewed through git.

## Layout

    spec/lifos/
    ├── lifos.json       product-group registration
    ├── features.json    cross-project feature matrix
    ├── schema.json      canonical data contract (10 entities, v3)
    ├── VERSION          Life OS version
    ├── bridge/
    │   └── FORMAT.md    canonical JSON exchange protocol
    └── ai/
        ├── README.md    Shared AI Layer overview
        ├── prompts/     3 runtime-agnostic prompts
        ├── council/     brains.json (11 brains)
        ├── policies/    rules + provider routing
        └── schemas/     I/O contracts

## Runtime counterpart

    ~/Life-OS/
    ├── .skb/lifos.json    →  symlink to spec/lifos/lifos.json
    ├── features.json      →  symlink
    ├── schema.json        →  symlink
    ├── VERSION            →  symlink
    ├── ai/                →  symlink to spec/lifos/ai/
    └── bridge/exports/    →  runtime-only (gitignored)

## Editing rules

- Never edit `~/Life-OS/*.json` directly (they are symlinks)
- Edit here, then `skb lifos doctor` will pick up changes
- `history.json` for Life OS is append-only (in bridge/exports)
