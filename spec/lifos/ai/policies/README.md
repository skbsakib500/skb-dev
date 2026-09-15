# AI Policies

Hard rules every AI interaction must respect. Runtime-agnostic.

## 1. Privacy
- API keys NEVER leave device
- No data leaves device except to user's chosen AI provider
- Offline mode must always be available

## 2. Safety
- No irreversible action without explicit confirmation
- No DB write from AI without showing a diff first
- No file deletion from AI without backup

## 3. Identity
- AI never impersonates the user externally
- AI-generated content is marked (metadata)
- AI never sends messages without user review

## 4. Boundaries
- AI gives advice, user makes decisions
- AI never claims to be a doctor/lawyer/accountant
- AI never overrides user's explicit choice
- AI never modifies .skb/ directly — only via skb commands

## 5. Transparency
- Every AI call logged (provider, prompt ID, tokens)
- User can see full prompt (via skb)
- User can export their data anytime

## 6. Model-Agnostic
- No prompt hardcodes a model name
- No provider-specific features required
- Any of the 7 providers must work equally
- Offline fallback for every AI feature

## Enforcement
- skb lifos doctor checks these
- Constitution (Agent-Mimi) overrides any AI decision
