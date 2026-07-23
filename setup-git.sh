#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info()  { printf "\033[34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[32m[ok]\033[0m    %s\n" "$1"; }

if ! command -v stow &>/dev/null; then
  info "Installing stow via Homebrew..."
  brew install stow
fi

stow -d "$DOTFILES" -t "$HOME" --restow git
ok "Stowed git config"
