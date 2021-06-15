if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.work ]; then
  source ~/.work
fi

#################################################################################
# ---------- alias ----------
alias kube="kubectl"
alias mk="minikube"
alias kns="kubens"
alias free="ruby ~/Applications/free-memory.rb"
alias da="deactivate"
alias wo="workon"
alias gc="gcloud"

eval "$(direnv hook bash)"

#################################################################################
# ---------- gcloud sdk ----------

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/chan/google-cloud-sdk/path.bash.inc' ]; then . '/Users/chan/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/chan/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/chan/google-cloud-sdk/completion.bash.inc'; fi


#################################################################################
# ---------- nvm ----------
export NVM_DIR="$HOME/.nvm"
# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  

#################################################################################
# ---------- rbenv ----------

eval "$(rbenv init -)"

#################################################################################
# ---------- pyenv ----------
export PATH=/Users/chan/.pyenv/shims/python2:$PATH
export PATH=/usr/local/opt/python/libexec/bin:$PATH
export PYENV_ROOT=~/.pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv init virtualenv-init -)"

#################################################################################
# ---------- poetry ----------

export PATH="$HOME/.poetry/bin:$PATH"

#################################################################################
# ---------- Virtualenv & Virtialenvwrapper ----------

export WORKON_HOME=$HOME/.virtualenvs
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper_lazy

#################################################################################
# ---------- terraform ----------

complete -C /usr/local/bin/terraform terraform
