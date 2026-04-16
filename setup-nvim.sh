#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info()  { printf "\033[34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[32m[ok]\033[0m    %s\n" "$1"; }
warn()  { printf "\033[33m[warn]\033[0m  %s\n" "$1"; }

if ! command -v stow &>/dev/null; then
  info "Installing stow via Homebrew..."
  brew install stow
fi

stow -d "$DOTFILES" -t "$HOME" --restow nvim
ok "Stowed nvim config"

if command -v nvim &>/dev/null; then
  info "Syncing plugins via lazy.nvim..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || warn "Lazy sync failed — run manually"
  ok "Neovim plugins synced"
else
  warn "nvim not found — install Neovim to complete setup"
fi

ok "Done!"
