# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.pre.zsh"
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

# Golang (Homebrew)
export GOROOT="/opt/homebrew/opt/go/libexec"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# PostgreSQL CLI binaries
export PATH="$PATH:/Library/PostgreSQL/15/bin"

# OpenSSL (just in case something needs it)
export OPENSSL_DIR="/usr/bin/openssl"

# Bash deprecation silence (harmless)
export BASH_SILENCE_DEPRECATION_WARNING=1

# pyenv-virtualenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zprofile.post.zsh"
