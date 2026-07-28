---
name: python
description: Python development conventions and tooling. Use when writing, reviewing, or debugging Python code.
---

## Environment
- uv for package/project management
- pyenv for Python version management
- Python 3.14 default, 3.13+ minimum for new projects

## Project Setup
- `uv init <project>` for new projects
- `uv add <dep>` for dependencies
- `uv run` to execute in project environment
- pyproject.toml for all config — no setup.py, no requirements.txt

## Conventions
- Type hints on all function signatures
- Pydantic for data validation and settings
- Prefer httpx over requests (async support)
- pathlib over os.path
- f-strings over .format()

## Docstrings
- Simple functions: one-line description
- Complex functions: full Google-style (description, args, returns, raises)
- Modules and classes: concise but useful description

## Style
- Ruff for linting and formatting
- If project has no ruff config, suggest adding it
- Follow PEP 8 (enforced by ruff)
- Prefer explicit over implicit
