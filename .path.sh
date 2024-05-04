
# User defined binaries
export PATH=$HOME/bin:$PATH

export PATH=/usr/local/sbin:$PATH

# HomeBrew
export PATH=/opt/homebrew/bin:$PATH


# Default Python: Miniconda
if [[ -d "$HOME/miniconda/bin" ]]; then
	export PATH=$HOME/miniconda/bin:$PATH
elif [[ -d "$HOME/miniconda3/bin" ]]; then
	export PATH=$HOME/miniconda3/bin:$PATH
fi

# Ruby
RUBY_VERSION='2.7.3'
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.rbenv/plugins/ruby-build/bin:$PATH
eval "$(rbenv init -)"
PATH=$HOME/.gem/ruby/$RUBY_VERSION/bin:$PATH

# npm
# npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH

# cargo
export PATH=$HOME/.cargo/bin:$PATH

# tmux
export TMUXINATOR_CONFIG=$HOME/.tmux
ln -sf $HOME/.tmux/tmux.conf $HOME/.tmux.conf
#ln -sf $HOME/.tmux/tmux-osx.conf $HOME/.tmux-osx.conf

# CUDA
if [[ $(uname -s) == Linux ]]; then
    export PATH=/usr/local/cuda/bin:$PATH
    export CUDA_HOME=/usr/local/cuda
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
fi


# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/home/j-min/google-cloud-sdk/path.zsh.inc' ]; then source '/home/j-min/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/home/j-min/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/j-min/google-cloud-sdk/completion.zsh.inc'; fi
