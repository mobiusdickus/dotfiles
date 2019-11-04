################################################################################
# ---------- Bash prompt customization ----------
#export PS1="❮\[\e[32m\]\h\[\e[m\]❯\[\e[36m\]\W\[\e[m\]:\[\e[37m\]\u\[\e[m\]$ "
export PS1="\[\e[38;5;203m\]\u\[\e[m\]@\[\e[92m\]\h\[\e[m\]:\[\e[96m\]\W\[\e[m\]\\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

################################################################################
# ---------- Bash completion ----------
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
#  . $(brew --prefix)/etc/bash_completion
#fi

################################################################################
# --------- Docker Machine ---------
#eval $(docker-machine env default)

#################################################################################
# ---------- virtualenvwrapper ----------
#export WORKON_HOME=~/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh

#################################################################################
# ---------- NVM ----------
export NVM_DIR="/Users/Chan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

#################################################################################
# ---------- Eternal bash history ----------
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Bash History Realtime Update
shopt -s histappend

#################################################################################
# ---------- Terminal Fuzzy Search ---------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#################################################################################
# ---------- Jump ----------
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/ -/g' && echo
}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}
complete -F _completemarks jump unmark

#################################################################################
# ---------- Pyenv ----------
export PYENV_ROOT=~/.pyenv
eval "$(pyenv init -)"

#################################################################################
# ---------- Direnv ----------
eval "$(direnv hook bash)"

#################################################################################
# ---------- Misc ----------
#source /usr/local/opt/autoenv/activate.sh   # Load autoenv
#source ~/.apikeys                           # Load project based apikeys
export GIT_EDITOR=nvim                      # Define git text editor
export PYTHONDONTWRITEBYTECODE=True         # Don't produce .pyc or .pyo files
export NVIM_TUI_ENABLE_TRUE_COLOR=1         # Set neovim terminal color
export PATH="$PYENV_ROOT/bin:$PATH"

#################################################################################
# ---------- Aliases ----------
alias nv="nvim"
alias da="deactivate"
alias dcd="deactivate; cd;"
alias ls='ls -G'
alias ll='ls -laF'
alias l='ls -CF'
alias nvf=findInput
#alias api="docker exec -it api"

#################################################################################
# ---------- Internal Functions ----------
findInput() {
  nv $(find . -name *$1*)
}
