#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info()  { printf "\033[34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[32m[ok]\033[0m    %s\n" "$1"; }
warn()  { printf "\033[33m[warn]\033[0m  %s\n" "$1"; }

# ------------------------------------------------------------------------------
# Only what nvim itself needs to run (treesitter/telescope deps) - rest is optional, see README
for formula in stow neovim tree-sitter-cli ripgrep; do
  if ! command -v "$formula" &>/dev/null; then
    info "Installing $formula via Homebrew..."
    brew install "$formula"
  fi
done
ok "Prerequisites installed"

# ------------------------------------------------------------------------------
# Real dir (not a Stow-folded symlink) so backups/swaps/undo don't land inside this repo
mkdir -p "${HOME}/.config/nvim"
mkdir -p "${HOME}/.config/nvim/backups" "${HOME}/.config/nvim/swaps" "${HOME}/.config/nvim/undo"
ok "Prepared ~/.config/nvim (backups/swaps/undo dirs, unfolded for Stow)"

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
