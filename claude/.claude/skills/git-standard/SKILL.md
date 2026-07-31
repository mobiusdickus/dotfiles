---
name: git-standard
description: Git commit message conventions. Use when making commits or reviewing commit messages.
---

- Follow Conventional Commits v1.0.0.
- Format: `<type>(optional scope): <description>`
- Types: `feat`, `fix`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`, `build`.
- Keep messages short and concise — aim for under 72 characters.
- Lowercase type, lowercase description, no period at end.
- Use `!` for breaking changes: `feat!: description`.
- Optional body/footer separated by blank line — use sparingly.
- Never add a `Co-Authored-By: Claude` (or similar AI attribution) trailer.
