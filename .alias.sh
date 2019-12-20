
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
    # Macdown
    alias mdn=macdown
    
    # Julia
    if [ -d "/Applications.Julia-0.6.app" ]; then
        alias julia="/Applications/Julia-0.6.app/Contents/Resources/julia/bin/julia"
    fi
fi

# NVIDIA GPU
if [[ $(uname -s) == Linux ]]; then

    # gpustat
    alias watchgpu='gpustat --watch -cp -n0.5'

    # nvidia-docker
    alias docker=nvidia-docker

    # CUDA VISIBLE DEVICES
    alias gpuX="export CUDA_VISIBLE_DEVICES=''"
    alias gpu0="export CUDA_VISIBLE_DEVICES='0'"
    alias gpu1="export CUDA_VISIBLE_DEVICES='1'"
    alias gpu2="export CUDA_VISIBLE_DEVICES='2'"
    alias gpu3="export CUDA_VISIBLE_DEVICES='3'"
    alias gpu4="export CUDA_VISIBLE_DEVICES='4'"
    alias gpu5="export CUDA_VISIBLE_DEVICES='5'"
    alias gpu6="export CUDA_VISIBLE_DEVICES='6'"
    alias gpu7="export CUDA_VISIBLE_DEVICES='7'"
fi
