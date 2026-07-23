
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/profile.pre.bash"

#echo "Loading profile..."

#_______________________________________________________________________________
# --> Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

#_______________________________________________________________________________
# --> pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#_______________________________________________________________________________
# --> Poetry
command -v poetry >/dev/null || export PATH="$HOME/.local/bin:$PATH"

#_______________________________________________________________________________
# --> nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#_______________________________________________________________________________
# --> go
export GOROOT="/usr/local/go"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

#_______________________________________________________________________________
# --> psql
export PATH="$PATH:/Library/PostgreSQL/15/bin"

#_______________________________________________________________________________
# --> Aliases
alias ll="ls -la"
alias nv="nvim"
alias cloud-sql-proxy="/Users/chan/google-cloud-sdk/cloud-sql-proxy"
alias tf="terraform"
alias mk="minikube"

#_______________________________________________________________________________
# --> Misc
export BASH_SILENCE_DEPRECATION_WARNING=1
export OPENSSL_DIR="/usr/bin/openssl"


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/profile.post.bash"


# Added by Antigravity CLI installer
export PATH="/Users/chan/.local/bin:$PATH"
