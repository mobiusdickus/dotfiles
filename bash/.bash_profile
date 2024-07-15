#echo "Loading bash_profile..."

if [ -f ~/.profile ]; then
	. ~/.profile
fi

if [ -f ~/.bashrc ]; then 
    .  ~/.bashrc; 
fi

complete -C /opt/homebrew/bin/terraform terraform
