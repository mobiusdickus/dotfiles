# dotfiles

Personal config files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

```bash
git clone https://github.com/mobiusdickus/dotfiles.git ~/projects/personal/dotfiles
cd ~/projects/personal/dotfiles
```

Requires [Homebrew](https://brew.sh). Then run whichever of these you need:

| Script | What it does |
|---|---|
| `./setup-git.sh` | Installs `stow`, stows `.gitconfig` |
| `./setup-zsh.sh` | Installs `stow`/`lsd`, clones [Zprezto](https://github.com/sorin-ionescu/prezto), stows the zsh configs, sets zsh as default shell |
| `./setup-nvim.sh` | Installs `stow`/`neovim`/`tree-sitter-cli`/`ripgrep`, stows the config, syncs plugins via [lazy.nvim](https://github.com/folke/lazy.nvim) |
| `./setup-claude.sh` | Installs `stow`/`jq`, stows the Claude Code config/skills, installs the gopls/pyright/typescript LSP plugins, registers the context7/obsidian MCP servers |
| `./setup-codex.sh` | Installs `stow`, stows the Codex CLI global `AGENTS.md`, registers the context7/obsidian MCP servers |

Each script only installs what's actually required for that config to run — everything else (icons, markdown preview, etc.) is optional; see below.

## Structure

```
├── zsh/
│   ├── .zshrc            # Zsh config (prezto + custom prompt/aliases)
│   ├── .zshenv           # Env vars for non-interactive shells; sources ~/.secrets and ~/.work
│   ├── .zprofile         # Login shell setup (PATH, tools)
│   └── .zpreztorc        # Prezto module config
├── nvim/.config/nvim/
│   └── init.lua          # Neovim config (lazy.nvim)
├── git/
│   └── .gitconfig
├── bash/
│   ├── .bashrc
│   ├── .bash_profile
│   └── .profile
├── claude/.claude/
│   ├── settings.json       # Permissions, statusline, enabled plugins
│   ├── CLAUDE.md           # Global instructions
│   ├── statusline-command.sh
│   └── skills/             # git-standard, go, python, typescript
├── codex/.codex/
│   └── AGENTS.md           # Global instructions
├── setup-git.sh
├── setup-zsh.sh
├── setup-nvim.sh
├── setup-claude.sh
└── setup-codex.sh
```

## Using Stow directly

The scripts install prerequisites and then just run `stow`. Once a package is stowed, you edit the files straight through the symlinks — no need to re-run anything. You only need `stow` itself again if a package's file list changes (added/removed a dotfile) or a symlink got deleted:

```bash
cd ~/projects/personal/dotfiles
stow -t ~ --restow zsh    # or: git, nvim
```

**Careful with `nvim`**: if `~/.config/nvim` doesn't already exist as a real directory, Stow "folds" the whole thing into one symlink pointing into this repo — so nvim's runtime dirs (`backups/`, `swaps/`, `undo/`) end up *inside your git repo*. `setup-nvim.sh` avoids this by pre-creating `~/.config/nvim` (and those three subdirectories) as real directories first. If you ever stow `nvim` by hand, do the same first:

```bash
mkdir -p ~/.config/nvim/{backups,swaps,undo}
stow -t ~ --restow nvim
```

## Optional integrations

Everything below is guarded and does nothing if the tool isn't installed — none of it is required. Install only what you use:

| Tool | Enables |
|---|---|
| Hack Nerd Font (`brew install --cask font-hack-nerd-font`) | Icons in `lsd` and nvim (nvim-tree, bufferline, lualine) — set as your terminal's font after installing |
| [deno](https://deno.com) (`brew install deno`) | `peek.nvim`'s markdown preview build step |
| [pyenv](https://github.com/pyenv/pyenv) | Python interpreter versions |
| [uv](https://github.com/astral-sh/uv) | Python packages/projects, virtualenvs |
| [nvm](https://github.com/nvm-sh/nvm) | Node versions |
| [pnpm](https://pnpm.io) (`brew install pnpm`) | Node packages |
| Go | `$GOPATH`/`$GOROOT`; also needed for Neovim's Mason to build `gopls` |
| PostgreSQL 15 client | `psql` on `PATH` |
| [OrbStack](https://orbstack.dev) / Docker Desktop | Container CLI + completions |
| [direnv](https://direnv.net) | Per-directory env vars |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy history/file search |
| [Terraform](https://www.terraform.io) | `tf` alias + autocomplete |
| [minikube](https://minikube.sigs.k8s.io) | `mk` alias |
| AWS CLI | `awsp` profile-switcher |
| iTerm2 | Shell integration — run "Install Shell Integration" from its Shell menu |

## Notes

- Secrets (`~/.secrets`) and work credentials (`~/.work`) are sourced from `.zshenv`, not tracked by git.
- `~/.claude.json` (MCP server registrations plus account/session state) is not tracked by git — `setup-claude.sh` registers the `context7`/`obsidian` MCP servers via `claude mcp add-json` instead, so the account/cache noise in that file never ends up in the repo.
- Likewise, `~/.codex/config.toml` is not tracked — it mixes portable prefs (model, plugins) with app-managed and machine-local state (marketplaces, desktop-app MCP entries, per-project trust levels that grow over time). `setup-codex.sh` registers the `context7`/`obsidian` MCP servers via `codex mcp add` instead, same reasoning as Claude.
- The `obsidian` MCP server proxies to the Obsidian desktop app's Local REST API plugin — it only works while Obsidian is open with that plugin enabled and `OBSIDIAN_API_TOKEN` set in `~/.secrets`. `setup-claude.sh`/`setup-codex.sh` both print a reminder for this since it can't be automated.

## Troubleshooting

- **Stow conflicts** (`~/.zshrc`/`.zprofile`/`.zshenv` already exist as real files): back them up first — `mv ~/.zprofile ~/.zprofile.pre-dotfiles.bak` — then fold anything worth keeping into the repo's version before restowing.
- **Icons still missing after setting the font**: the change only applies to new windows/tabs. Close and reopen the one you're testing in.
- **`nvm` installed via Homebrew but not loading**: `.zprofile` expects Homebrew's path (`$HOMEBREW_PREFIX/opt/nvm`); run `mkdir ~/.nvm` once after installing.
- **Neovim's Mason fails to install `pyright`/`ts_ls`/`gopls`**: they need `npm` (Node) and `go` on `PATH` respectively. Install the runtime, then retry via `:Mason` or `:MasonInstall pyright typescript-language-server gopls`.
