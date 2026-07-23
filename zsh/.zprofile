# ~/.zprofile

# Homebrew (Apple Silicon or Intel)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null && eval "$(pyenv init --path)"

# uv (Python package/project manager)
command -v uv >/dev/null || export PATH="$HOME/.local/bin:$PATH"

# nvm (Homebrew path, not the official installer's ~/.nvm/nvm.sh)
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# Golang (Homebrew)
export GOROOT="$HOMEBREW_PREFIX/opt/go/libexec"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# PostgreSQL CLI binaries
export PATH="$PATH:/Library/PostgreSQL/15/bin"

# OpenSSL (just in case something needs it)
export OPENSSL_DIR="/usr/bin/openssl"

# Bash deprecation silence (harmless)
export BASH_SILENCE_DEPRECATION_WARNING=1

# pyenv
command -v pyenv >/dev/null && eval "$(pyenv init -)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# >>> Codex installer >>>
export PATH="$HOME/.local/bin:$PATH"
# <<< Codex installer <<<
