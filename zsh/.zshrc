
# ------------------------------------------------------------------------------
# Prezto
# ------------------------------------------------------------------------------
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ------------------------------------------------------------------------------
# Terminal colors
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# ------------------------------------------------------------------------------
# History
HISTFILE=~/.zsh_eternal_history
HISTSIZE=999999
SAVEHIST=999999
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

# ------------------------------------------------------------------------------
# Arrow key search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ------------------------------------------------------------------------------
# Prompt setup
setopt PROMPT_SUBST

get_git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
    if [[ -n "$branch" ]]; then
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            branch="$branch *"
        fi
        echo "$branch"
    fi
}

get_virtualenv() {
    [[ -n "$VIRTUAL_ENV" ]] && echo "$(basename "$VIRTUAL_ENV")"
}

get_aws_profile() {
    [[ -n "$AWS_PROFILE" ]] && echo "$AWS_PROFILE"
}

get_gcp_project() {
    gcloud config get-value project 2>/dev/null
}

update_prompt() {
    PROMPT="%F{cyan}%n%f@%F{magenta}%m%f ❯ %F{245}%~%f"
    
    # Add additional prompt output functions if wanted

    PROMPT+="
~$ "
}

precmd_functions+=(update_prompt)

# ------------------------------------------------------------------------------
# Aliases
alias ls="lsd"
alias ll="lsd -la"
alias lt="lsd --tree"
alias nv="nvim"
alias tf="terraform"
alias mk="minikube"

# AWS profile switcher
awsp() {
    if [[ -z "$1" ]]; then
        echo "Usage: awsp <profile-name> | awsp clear"
        return 1
    fi
    if [[ "$1" == "clear" ]]; then
        unset AWS_PROFILE
        echo "Cleared AWS profile"
        return 0
    fi
    if ! aws configure list-profiles | grep -q "^$1$"; then
        echo "Error: Profile '$1' not found"
        echo "Available profiles:"
        aws configure list-profiles
        return 1
    fi
    export AWS_PROFILE=$1
    echo "Switched to AWS profile: $1"
}

# ------------------------------------------------------------------------------
# Mark & Jump system
export MARKPATH=$HOME/.marks

mark() { mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"; }
jump() { cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"; }
unmark() { rm -i "$MARKPATH/$1"; }
marks() { ls -l "$MARKPATH" | awk '{print $9}' | sed 's/ -/ -/'; }

_jump_mark() {
    local -a marks
    marks=($(ls "$MARKPATH"))
    _describe 'marks' marks
}
compdef _jump_mark jump unmark

# ------------------------------------------------------------------------------
# Lazy loading
command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
type terraform > /dev/null 2>&1 && autoload -U +X bashcompinit && bashcompinit && complete -o nospace -C $(which terraform) terraform

# Docker CLI completions
[ -d "$HOME/.docker/completions" ] && fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit
compinit

# iTerm2 shell integration - enable via "Install Shell Integration" in iTerm2's Shell menu
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
