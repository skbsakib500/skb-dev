# SKB Dev Ecosystem

> **Build Once. Track Everything. Update Safely. Remember Forever.**
>
> Personal development infrastructure — unified identity, portable
> project memory, model-agnostic AI, and safe automation.

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Schema](https://img.shields.io/badge/schema-v1-green.svg)](spec/)
[![Version](https://img.shields.io/badge/version-v1.2.0-blue.svg)](CHANGELOG.md)

---

## What is this?

SKB Dev is a **control plane** for all my software projects —
built for Termux, portable to any POSIX shell.

Every project carries its own memory (`.skb/`) — identity, state,
history, modules, assets. The `skb` command reads that memory
and gives a unified view across the whole ecosystem.

**AI models change every few months. Product memory does not.**

---

## Philosophy

| Principle | How |
|-----------|-----|
| **Source of truth lives with the code** | `.skb/` + `*.md` inside each repo |
| **Model-agnostic** | Project context exported via `skb ai-context` — works with ChatGPT, Claude, Gemini, DeepSeek equally |
| **No direct DB-to-DB sync** | Everything through canonical JSON — validated before apply |
| **No secrets, ever** | Pre-commit hook scans staged files for tokens |
| **Append-only history** | `history.json` never rewritten |
| **Explicit confirmation** | Destructive ops ask first — always |

---

## Ecosystem

    SKB-Dev  ← you are here (control plane)
       │
       ├── spec/lifos/        Life OS canonical spec
       │
       ├── Agent-Mimi        Python brain (Life OS core)
       ├── Mimi-Android      Android delivery (WebView + Python)
       ├── SKB-Player        Kotlin video player
       ├── SKB-Music         Kotlin music player
       └── SKB-Dev           this CLI

All 5 projects on **Schema v1** — see `spec/v1/README.md`.

---

## Install

    git clone https://github.com/skbsakib500/skb-dev.git ~/SKB-Dev
    cp ~/SKB-Dev/skb ~/bin/skb
    chmod +x ~/bin/skb
    export PATH="$HOME/bin:$PATH"

No dependencies beyond `bash`, `git`, `python3`, `coreutils`.

---

## Commands

### Ecosystem

    skb                    interactive dashboard
    skb projects           all registered projects
    skb status             current project details
    skb all                detailed view (all projects)
    skb log <name>         recent commits
    skb todo <name>        open TODOs
    skb issues <name>      open issues

### Memory & Context

    skb context <name>              project snapshot (human)
    skb context <name> --ai         AI-ready block
    skb context <name> --json       machine-readable
    skb ai-context <name>           full prompt (markdown)
    skb ai-context <name> --format=json

### Security

    skb scan <name>        secret scan on tracked files
    skb scan --all         ecosystem-wide
    skb audit <name>       rule compliance check
    skb guard install      pre-commit hook
    skb guard status

### Release

    skb release <name> <version>   guided release workflow

### Life OS

    skb lifos              overview
    skb lifos features     cross-project feature matrix
    skb lifos context      AI-ready Life OS context
    skb lifos version      version sync check
    skb lifos doctor       health check
    skb lifos bridge export <src>
    skb lifos bridge import <target> <file> [--dry-run|--confirm]

---

## Architecture

    spec/lifos/                ← canonical (git-tracked)
    ├── lifos.json              product-group registration
    ├── features.json           38 features × brain/android/sync
    ├── schema.json             10 entities, v3
    ├── VERSION                 13.0.0
    ├── bridge/FORMAT.md        canonical JSON protocol
    └── ai/                     Shared AI Layer
        ├── prompts/            3 runtime-agnostic prompts
        ├── council/            11 brains spec
        ├── policies/           rules + provider routing
        └── schemas/            I/O contracts

    ~/Life-OS/                 ← runtime workspace (symlinks)
    ├── VERSION                 → spec/lifos/VERSION
    ├── ai/                     → spec/lifos/ai/
    ├── bridge/exports/         (gitignored, runtime only)
    └── .skb/lifos.json         → spec/lifos/lifos.json

**Rule:** `spec` is canonical · runtime is adapter ·
generated/cached prompt is never canonical.

See `spec/lifos/README.md` for full details.

---

## Design

### `.skb/` — machine-readable project state

Six files per project (Schema v1):

| File | Purpose |
|------|---------|
| `project.json` | identity — who, what, where |
| `state.json` | current snapshot |
| `history.json` | timeline (append-only) |
| `config.json` | per-project behavior |
| `modules.json` | module registry |
| `assets.json` | asset registry |

### Prompt loading (canonical spec)

    spec/lifos/ai/prompts/daily_plan.md
                    ↓
    ┌───────────────┼───────────────┐
    │                               │
    Agent-Mimi (Python)         Mimi-Android (JS)
    prompt_loader.py            sync-prompts.py
    → build_prompt()            → generated.js
                                → buildPromptFromSpec()

Same spec, both runtimes. No duplication.

---

## Requirements

- Termux (or any POSIX shell)
- `bash` 5+, `git`, `python3` 3.10+
- Optional: `gh` CLI (for GitHub ops)

---

## Contributing

This is a personal project. Issues and suggestions welcome.

- Read `DEVELOPMENT.md` for dev workflow
- Read `DECISIONS.md` for architectural reasoning
- Read `KNOWN-ISSUES.md` for known gaps

---

## License

Apache License 2.0 — see `LICENSE`.

---

## Author

**SKB Dev**
- GitHub: [@skbsakib500](https://github.com/skbsakib500)
- Email: msakibalmhamud5@gmail.com

_Build. Remember. Evolve. Release._
