#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info()  { printf "\033[34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[32m[ok]\033[0m    %s\n" "$1"; }
warn()  { printf "\033[33m[warn]\033[0m  %s\n" "$1"; }

# ------------------------------------------------------------------------------
if ! command -v stow &>/dev/null; then
  info "Installing stow via Homebrew..."
  brew install stow
fi
ok "Prerequisites installed"

if ! command -v codex &>/dev/null; then
  warn "Codex CLI not found on PATH — install it first, then re-run this script"
  exit 1
fi

# ------------------------------------------------------------------------------
# Existing real file (not yet a Stow symlink) will conflict with stow - move it
# aside so the repo's copy wins, same pattern as the zsh/nvim troubleshooting notes.
target="$HOME/.codex/AGENTS.md"
if [ -e "$target" ] && [ ! -L "$target" ]; then
  mv "$target" "$target.pre-dotfiles.bak"
  warn "Backed up existing ~/.codex/AGENTS.md to AGENTS.md.pre-dotfiles.bak"
fi

stow -d "$DOTFILES" -t "$HOME" --restow codex
ok "Stowed Codex config"

# Use the same canonical skills as Claude while exposing them through Codex's
# global user-skill discovery directory.
skills_target="$HOME/.agents/skills"
if [ -L "$skills_target" ]; then
  mv "$skills_target" "$skills_target.pre-dotfiles.bak"
  warn "Backed up existing ~/.agents/skills symlink to skills.pre-dotfiles.bak"
fi
mkdir -p "$skills_target"
stow -d "$DOTFILES" -t "$skills_target" --restow skills
ok "Stowed shared skills for Codex"

# ------------------------------------------------------------------------------
# MCP servers
# config.toml itself isn't tracked/stowed — it mixes portable prefs with
# app-managed and machine-local state (marketplaces, project trust levels,
# desktop-app MCP entries), same reasoning as leaving ~/.claude.json untracked.
if ! codex mcp get context7 &>/dev/null; then
  codex mcp add context7 -- npx -y @upstash/context7-mcp >/dev/null
  ok "Added context7 MCP server"
else
  ok "context7 MCP server already configured"
fi
command -v npx &>/dev/null || warn "npx not found on PATH — context7 MCP server needs Node to actually run"

if ! codex mcp get obsidian &>/dev/null; then
  codex mcp add obsidian --url http://127.0.0.1:27123/mcp/ --bearer-token-env-var OBSIDIAN_API_TOKEN >/dev/null
  ok "Added obsidian MCP server"
else
  ok "obsidian MCP server already configured"
fi

warn "Manual steps needed to finish Obsidian MCP setup (can't be automated here):"
warn "  1. Install/enable the 'Local REST API' community plugin inside Obsidian"
warn "  2. Copy the API key it generates into ~/.secrets as: export OBSIDIAN_API_TOKEN=<key>"
warn "  3. Keep Obsidian running with that vault open — the MCP server proxies to it on 127.0.0.1:27123"

ok "Done! Restart Codex for the AGENTS.md/MCP server changes to take effect"
