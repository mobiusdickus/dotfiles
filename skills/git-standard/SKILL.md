---
name: git-standard
description: Git commit message conventions. Use when making commits or reviewing commit messages.
---

- Follow Conventional Commits v1.0.0.
- Format: `<type>(optional scope): <description>`
- Types: `feat`, `fix`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`, `build`.
- Keep the subject concise: one line, ideally 50 characters and never more than 72.
- State the primary outcome, not a list of files changed or implementation details.
- Omit a body unless it adds essential context that the subject cannot convey.
- Lowercase type, lowercase description, no period at end.
- Use `!` for breaking changes: `feat!: description`.
- Optional body/footer separated by blank line — use sparingly.
- Never add a `Co-Authored-By` or similar AI-attribution trailer for Claude, Codex, or another AI assistant.
