# ~/.zprofile

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Poetry (Python package manager)
command -v poetry >/dev/null || export PATH="$HOME/.local/bin:$PATH"

# nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="/Users/chan/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Golang
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# PostgreSQL CLI binaries
export PATH="$PATH:/Library/PostgreSQL/15/bin"

# OpenSSL (just in case something needs it)
export OPENSSL_DIR="/usr/bin/openssl"

# Bash deprecation silence (harmless)
export BASH_SILENCE_DEPRECATION_WARNING=1
