
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.pre.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.pre.bash"

#echo "Loading bash_profile..."

if [ -f ~/.profile ]; then
	. ~/.profile
fi

if [ -f ~/.bashrc ]; then 
    .  ~/.bashrc; 
fi

complete -C /opt/homebrew/bin/terraform terraform


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.post.bash" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/bash_profile.post.bash"


# Added by Antigravity CLI installer
export PATH="$HOME/.local/bin:$PATH"
