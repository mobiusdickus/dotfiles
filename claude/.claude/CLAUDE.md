# Global Claude Instructions

## Documentation

Use context7 (`mcp__context7__resolve-library-id` → `mcp__context7__query-docs`) when recency matters — API signatures, config options, migrations. Skip it for stable fundamentals.

## Obsidian

Vault: `mobius`. Keep triggers narrow — don't spam searches or notes for trivial/mechanical requests.
- **Search first** for anything with a plausible prior note (people, projects, past decisions) — `mcp__obsidian__search_simple` before answering from general knowledge.
- **Check vault context** only with real signal (journal-worthy topic, likely hit) — not before every task.
- **Auto-capture** only on explicit cues ("note this," "remember this") — never for routine in-session choices. Match existing vault conventions.

**Memory vs. Obsidian**: memory = how to work with you / project state, session-to-session. Obsidian = your durable personal notes, meant for you to read. Explicit note/remember request: personal note-to-self → Obsidian; about working with you/the project → memory; genuinely both → both, but don't duplicate by default.

## Git

Before any `git commit`, check for and load the `git-standard` skill rather than defaulting to built-in commit conventions.
