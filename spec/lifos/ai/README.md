# Shared AI Layer

Model-agnostic AI specification for Mimi Life OS.

Principle: **Prompt + rules live here. Provider code lives in each runtime.**

## Structure
    Life-OS/ai/
      prompts/    markdown specs (id, version, inputs)
      council/    brains.json + protocol
      policies/   hard rules + provider routing
      schemas/    I/O contracts

## Runtimes
- **Agent-Mimi** (Python) — `mimi/multi_ai.py` + `mimi/ai_plan.py`
- **Mimi-Android** (JS) — `tools/ai_plan.js` + bridge

Both read from this directory (via symlink or copy).

## Why separate?
AI models change every 3 months. Providers rise and fall. But
product behavior — what Mimi asks, how she thinks — stays
consistent. This directory is that consistency.

## Adding a prompt
1. Create prompts/<id>.md with YAML frontmatter
2. Declare inputs: and outputs:
3. Implement in each runtime
4. Test with 2 providers
5. Update policies/providers.json if routing changes

## Adding a provider
1. Update policies/providers.json
2. Implement adapter in each runtime
3. No prompt changes required
