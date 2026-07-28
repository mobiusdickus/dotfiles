#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info()  { printf "\033[34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[32m[ok]\033[0m    %s\n" "$1"; }
warn()  { printf "\033[33m[warn]\033[0m  %s\n" "$1"; }

# ------------------------------------------------------------------------------
for formula in stow jq; do
  if ! command -v "$formula" &>/dev/null; then
    info "Installing $formula via Homebrew..."
    brew install "$formula"
  fi
done
ok "Prerequisites installed"

if ! command -v claude &>/dev/null; then
  warn "Claude Code CLI not found on PATH — install it first, then re-run this script"
  exit 1
fi

# ------------------------------------------------------------------------------
# Existing real files (not yet Stow symlinks) will conflict with stow - move them
# aside so the repo's copies win, same pattern as the zsh/nvim troubleshooting notes.
for f in settings.json CLAUDE.md statusline-command.sh skills; do
  target="$HOME/.claude/$f"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.pre-dotfiles.bak"
    warn "Backed up existing ~/.claude/$f to $f.pre-dotfiles.bak"
  fi
done

stow -d "$DOTFILES" -t "$HOME" --restow claude
ok "Stowed Claude config"

# ------------------------------------------------------------------------------
# LSP plugins
for plugin in gopls-lsp pyright-lsp typescript-lsp; do
  claude plugin install "$plugin@claude-plugins-official" >/dev/null
done
ok "Installed LSP plugins (gopls, pyright, typescript)"

command -v go  &>/dev/null || warn "Go not found on PATH — gopls-lsp needs it to actually run"
command -v npm &>/dev/null || warn "npm not found on PATH — typescript-lsp needs it to actually run"
command -v python3 &>/dev/null || warn "python3 not found on PATH — pyright-lsp needs it to actually run"

# ------------------------------------------------------------------------------
# MCP servers
if ! claude mcp get context7 &>/dev/null; then
  claude mcp add-json context7 -s user '{"type":"stdio","command":"npx","args":["-y","@upstash/context7-mcp"],"env":{}}' >/dev/null
  ok "Added context7 MCP server"
else
  ok "context7 MCP server already configured"
fi
command -v npx &>/dev/null || warn "npx not found on PATH — context7 MCP server needs Node to actually run"

if ! claude mcp get obsidian &>/dev/null; then
  claude mcp add-json obsidian -s user '{"type":"http","url":"http://127.0.0.1:27123/mcp/","headers":{"Authorization":"Bearer ${OBSIDIAN_API_TOKEN}"}}' >/dev/null
  ok "Added obsidian MCP server"
else
  ok "obsidian MCP server already configured"
fi

warn "Manual steps needed to finish Obsidian MCP setup (can't be automated here):"
warn "  1. Install/enable the 'Local REST API' community plugin inside Obsidian"
warn "  2. Copy the API key it generates into ~/.secrets as: export OBSIDIAN_API_TOKEN=<key>"
warn "  3. Keep Obsidian running with that vault open — the MCP server proxies to it on 127.0.0.1:27123"

ok "Done! Restart Claude Code for the config/plugins/MCP servers to take effect"
