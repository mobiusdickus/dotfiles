
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

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
    # local GIT_BRANCH=$(get_git_branch)
    local VIRTUALENV=$(get_virtualenv)
    local AWS_PROF=$(get_aws_profile)

    PROMPT="%F{cyan}%n%f@%F{magenta}%m%f ❯ %F{245}%~%f"

    # if [[ -n "$GIT_BRANCH" ]]; then
    #     if [[ "$PWD" == *"goodlynx"* ]]; then
    #         local GCP_PROJECT=$(get_gcp_project)
    #         [[ -n "$GCP_PROJECT" ]] && PROMPT+=" ❯ %F{214}($GCP_PROJECT)%f"
    #     fi
    #     [[ -n "$VIRTUALENV" ]] && PROMPT+=" ❯ %F{yellow}($VIRTUALENV)%f"
    #     PROMPT+=" ❯ %F{green}[$GIT_BRANCH]%f"
    # fi

    [[ -n "$VIRTUALENV" ]] && PROMPT+=" ❯ %F{yellow}($VIRTUALENV)%f"
    [[ -n "$AWS_PROF" ]] && PROMPT+=" ❯ %F{208}aws:$AWS_PROF%f"

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
alias cloud-sql-proxy="$HOME/google-cloud-sdk/cloud-sql-proxy"
alias tf="terraform"
alias mk="minikube"
alias kc="kiro-cli"
alias kcr="kiro-cli chat --resume"
alias kcl="kiro-cli login"
alias antig="agy"

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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
type terraform > /dev/null 2>&1 && autoload -U +X bashcompinit && bashcompinit && complete -o nospace -C $(which terraform) terraform

# Docker CLI completions
fpath=(/Users/cchan/.docker/completions $fpath)
autoload -Uz compinit
compinit

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"

# egcli
if [ -f '/Users/cchan/Library/Group Containers/FELUD555VC.group.com.egnyte.DesktopApp/CLI/egcli.inc' ]; then . '/Users/cchan/Library/Group Containers/FELUD555VC.group.com.egnyte.DesktopApp/CLI/egcli.inc'; fi

# Logi Build Haptics
source ~/.config/logi-build-haptics/integration.zsh


# Added by Antigravity CLI installer
export PATH="/Users/chan/.local/bin:$PATH"
