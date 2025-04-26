# ~/.zshrc

# ------------------------------------------------------------------------------
# Early setup: colors + completion
autoload -Uz colors compinit up-line-or-beginning-search down-line-or-beginning-search

colors
compinit -C  # Defer loading of completion system slightly

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
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# ------------------------------------------------------------------------------
# Prompt setup
setopt PROMPT_SUBST

get_gcp_project() {
    gcloud config get-value project 2>/dev/null
}

get_git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return

    if [[ -n "$branch" ]]; then
        # Check if there are uncommitted changes
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            branch="$branch *"
        fi
        echo "$branch"
    fi
}

update_prompt() {
    local GCP_PROJECT=""
    local GIT_BRANCH=""

    GIT_BRANCH=$(get_git_branch)

    PROMPT="%F{cyan}%n%f@%F{magenta}%m%f ❯ %F{245}%~%f"

    if [[ -n "$GIT_BRANCH" ]]; then
        if [[ "$PWD" == *"goodlynx"* ]]; then
            GCP_PROJECT=$(get_gcp_project)
            if [[ -n "$GCP_PROJECT" ]]; then
                PROMPT+=" ❯ %F{214}($GCP_PROJECT)%f"
            fi
        fi
        PROMPT+=" ❯ %F{green}[$GIT_BRANCH]%f"
    fi

    PROMPT+="
~$ "
}

precmd_functions+=(update_prompt)

# ------------------------------------------------------------------------------
# Aliases
alias ll="ls -la"
alias nv="nvim"
alias cloud-sql-proxy="/Users/chan/google-cloud-sdk/cloud-sql-proxy"
alias tf="terraform"
alias mk="minikube"

# ------------------------------------------------------------------------------
# Mark & Jump system
export MARKPATH=$HOME/.marks

mark() {
    mkdir -p "$MARKPATH"
    ln -s "$(pwd)" "$MARKPATH/$1"
}

jump() {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

unmark() {
    rm -i "$MARKPATH/$1"
}

marks() {
    ls -l "$MARKPATH" | awk '{print $9}' | sed 's/ -/ -/'
}

# Autocomplete for marks
_jump_mark() {
    local -a marks
    marks=($(ls "$MARKPATH"))
    _describe 'marks' marks
}
compdef _jump_mark jump unmark

# ------------------------------------------------------------------------------
# Lazy loading heavy things
# ------------------------------------------------------------------------------
# Load fzf if available
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# Load direnv
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# Load gcloud SDK bits if available
if [ -f '/Users/chan/google-cloud-sdk/path.zsh.inc' ]; then
    source '/Users/chan/google-cloud-sdk/path.zsh.inc'
fi
if [ -f '/Users/chan/google-cloud-sdk/completion.zsh.inc' ]; then
    source '/Users/chan/google-cloud-sdk/completion.zsh.inc'
fi

# ------------------------------------------------------------------------------
# Terraform autocomplete
if type terraform > /dev/null 2>&1; then
    complete -o nospace -C $(which terraform) terraform
fi
