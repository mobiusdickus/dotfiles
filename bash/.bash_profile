if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.work ]; then
  source ~/.work
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

export PATH="$HOME/.poetry/bin:$PATH"

export BASH_SILENCE_DEPRECATION_WARNING=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/chan/google-cloud-sdk/path.bash.inc' ]; then . '/Users/chan/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/chan/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/chan/google-cloud-sdk/completion.bash.inc'; fi

