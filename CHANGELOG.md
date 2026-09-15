# Changelog — SKB-Dev

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
