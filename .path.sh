
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

# tmux
export TMUXINATOR_CONFIG=$HOME/.tmux
#ln -sf $HOME/.tmux/tmux.conf $HOME/.tmux.conf
#ln -sf $HOME/.tmux/tmux-osx.conf $HOME/.tmux-osx.conf

# CUDA
#if exists_cuda; then
#    export PATH=/usr/local/cuda/bin:$PATH
#    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
#fi
