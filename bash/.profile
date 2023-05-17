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
# --> Aliases
alias ll="ls -la"
alias nv="nvim"

#_______________________________________________________________________________
# --> Misc
export BASH_SILENCE_DEPRECATION_WARNING=1
export OPENSSL_DIR="/usr/bin/openssl"
