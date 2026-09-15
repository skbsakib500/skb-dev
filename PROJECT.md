# SKB-Dev

## Identity

| Field | Value |
|-------|-------|
| Project ID | `skb-dev` |
| Display Name | SKB Dev CLI |
| Type | CLI tool (bash) |
| version | `0.2.0` |
| Status | **Active** |
| Author | SKB Dev |
| Purpose | Unified command center across SKB projects |

## What Is This

A single bash command (`skb`) that reads `.skb/` metadata
from every project and provides a unified dashboard.

No dependencies beyond bash, find, grep, awk, git.

## Commands

See README.md.

## Design Principles

- Zero dependencies
- Read-only on projects (never modifies)
- Machine-readable `.skb/` is source of truth
- Redact secrets in any output
