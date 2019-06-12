
alias vi=nvim
alias vim=nvim
alias oldvi='\vi'
alias oldvim='\vim'

# Python 2
alias python2=python2.7

# Replacement for 'git' for dotfile congiration
# Prior to the installation make sure you have committed the alias to your .bashrc or .zsh:
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Tmux
alias mux=tmuxinator
if [[ $(uname -s) == Linux ]]; then
    alias tm='tmuxinator start gpu-monitor-jupyter'
elif [[ $(uname -s) == Darwin ]]; then
    alias tm='tmuxinator start monitor-jupyter'
fi
alias tmk='tmux kill-session'

# Replacement for 'find'
#unalias fd

## Replacement for 'ls'
#if  [ -x "$(command -v exa)" ]; then
    #alias ls=exa
    #alias la='ls -la'
#fi
alias ls=lsd
alias la='ls -a'
alias lla='ls -la'

# MacOS
if [[ `uname` == 'Darwin' ]]; then
    # MacVim
	alias vim="/Applications/MacVim.app/Contents/MacOS/Vim"
	alias vi="/Applications/MacVim.app/Contents/MacOS/Vim"

    # Macdown
    alias mdn=macdown
    
    # Julia
    if [ -d "/Applications.Julia-0.6.app" ]; then
        alias julia="/Applications/Julia-0.6.app/Contents/Resources/julia/bin/julia"
    fi
fi

# gpustat
alias watchgpu='watch --color -n0.2 gpustat'

# nvidia-docker
alias docker=nvidia-docker

# Conda environment
# Create a conda env with data science packages
# alias cenv='conda create --file ~/.make/conda-data-science-requirements.txt -n'
alias workon='conda activate'
alias deactivate='conda deactivate'
