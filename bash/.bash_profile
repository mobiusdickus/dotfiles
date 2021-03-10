if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

if [ -f ~/.work ]; then
  source ~/.work
fi

export PATH="$HOME/.poetry/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/chan/google-cloud-sdk/path.bash.inc' ]; then . '/Users/chan/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/chan/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/chan/google-cloud-sdk/completion.bash.inc'; fi
