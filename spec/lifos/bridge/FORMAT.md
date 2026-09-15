# Life OS Bridge — Canonical JSON Format

Schema: `skb/lifos-canonical/v1`

Purpose: portable data exchange between Life OS runtimes.
NEVER direct DB-to-DB. ALWAYS through this contract.

## Envelope

{
  "format": "skb/lifos-canonical/v1",
  "schema_version": 3,
  "exported_at": "ISO8601",
  "source": "skb-agent-mimi" | "skb-mimi-android" | ...,
  "entities": { "<Entity>": [ {...}, {...} ] }
}

## Entity Rules

- Only entities declared in `Life-OS/schema.json` allowed.
- Each entity includes only declared fields.
- `id` is the primary key — used for upsert matching.
- Missing `required` fields → validation error.
- Unknown fields → warning, dropped on import.

## Merge Semantics

On import:
- Existing id → upsert (update non-null fields)
- New id → insert
- Deletion NOT propagated (safety — see DECISIONS)
- Conflict → last-write-wins by `updated_at` if present

## Safety

- `--dry-run` (default): show diff only
- `--confirm`: actually apply
- Backup before import (auto)
