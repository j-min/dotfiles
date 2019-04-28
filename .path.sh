
# Anaconda as main default Python
if [[ -d "$HOME/anaconda/bin" ]]; then
	export PATH=$HOME/anaconda/bin:$PATH
fi

if [[ -d "$HOME/anaconda3/bin" ]]; then
	export PATH=$HOME/anaconda3/bin:$PATH
fi

# tmux
export TMUXINATOR_CONFIG=$HOME/.tmux
ln -sf $HOME/.tmux/tmux.conf $HOME/.tmux.conf
ln -sf $HOME/.tmux/tmux-osx.conf $HOME/.tmux-osx.conf

# CUDA 8.0
export PATH=/usr/local/cuda-8.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64:$LD_LIBRARY_PATH

# Virtualenv & Virtualenvwrapper
# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh
