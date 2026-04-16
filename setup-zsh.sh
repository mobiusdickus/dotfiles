#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info()  { printf "\033[34m[info]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[32m[ok]\033[0m    %s\n" "$1"; }

if ! command -v stow &>/dev/null; then
  info "Installing stow via Homebrew..."
  brew install stow
fi

if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  info "Cloning Zprezto..."
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  ok "Cloned Zprezto"
else
  ok "Zprezto already installed"
fi

stow -d "$DOTFILES" -t "$HOME" --restow zsh
ok "Stowed zsh configs"

if [ "$SHELL" != "$(which zsh)" ]; then
  info "Setting zsh as default shell..."
  chsh -s "$(which zsh)"
  ok "Default shell set to zsh"
fi

ok "Done! Run: exec zsh"
