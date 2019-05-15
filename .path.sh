
# Default Python: Anaconda
if [[ -d "$HOME/anaconda/bin" ]]; then
	export PATH=$HOME/anaconda/bin:$PATH
elif [[ -d "$HOME/anaconda3/bin" ]]; then
	export PATH=$HOME/anaconda3/bin:$PATH
fi

# Ruby
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.rbenv/plugins/ruby-build/bin:$PATH
eval "$(rbenv init -)"
PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH

# npm
# npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH

# tmux
export TMUXINATOR_CONFIG=$HOME/.tmux
#ln -sf $HOME/.tmux/tmux.conf $HOME/.tmux.conf
#ln -sf $HOME/.tmux/tmux-osx.conf $HOME/.tmux-osx.conf

# CUDA 10.0
if [ $(uname -s) == Linux ]; then
    export PATH=/usr/local/cuda-10.0/bin:$PATH
    export CUDA_HOME=/usr/local/cuda-10.0
    export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64:$LD_LIBRARY_PATH
fi

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/home/j-min/google-cloud-sdk/path.zsh.inc' ]; then source '/home/j-min/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/home/j-min/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/j-min/google-cloud-sdk/completion.zsh.inc'; fi
