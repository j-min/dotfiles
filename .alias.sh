
# Python 2
alias python2=python2.7

# Replacement for 'git' for dotfile congiration
# Prior to the installation make sure you have committed the alias to your .bashrc or .zsh:
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Safe reattach-to-user-namespace
if [ -n "$(command -v reattach-to-user-namespace)" ]; then
	reattach-to-user-namespace $@
else
	exec "$@"
fi

# Tmux
alias mux=tmuxinator
alias tm='tmuxinator start monitor-jupyter'
alias tmk='tmux kill-session'

# Replacement for 'find'
if  [ -x "$(command -v fd)" ]; then
    unalias fd
fi

# Replacement for 'ls'
if  [ -x "$(command -v exa)" ]; then
    alias ls=exa
    alias la='ls -la'
fi

# Vim
if [[ `uname` == 'Darwin' ]]; then
	alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
	alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"

    if [ -d "/Applications.Julia-0.6.app" ]; then
        alias julia="/Applications/Julia-0.6.app/Contents/Resources/julia/bin/julia"
    fi
fi

# gpustat
if  [ -x "$(command -v gpustat)" ]; then
    alias watchgpu='watch --color -n0.2 gpustat'
fi

# conda environment
if [ -x "$(command -v conda)" ]; then
    # Create a conda env with data science packages
    alias cenv='conda create --file ~/.make/conda-data-science-requirements.txt -n'

    alias workon='source activate'
    alias deactivate='source deactivate'
fi