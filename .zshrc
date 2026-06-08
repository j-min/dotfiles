ZSH=$HOME/.zsh

HISTFILE=$HOME/.history
HISTSIZE=10000
SAVEHIST=10000

export TERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export SHELL=/bin/zsh
export EDITOR=nvim


# import environment path
source $HOME/.path.sh

# Workspace/local-only commands (kept out of git)
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
if [ -d "$HOME/.zshrc.local.d" ]; then
    for local_zsh_file in "$HOME"/.zshrc.local.d/*.zsh; do
        [ -e "$local_zsh_file" ] || continue
        source "$local_zsh_file"
    done
fi

# Activate base anaconda envrionment
source activate base

####################################
## Antigen: Configuration Start ##
####################################

# Load Antigen
source $ZSH/antigen.zsh

# Load Oh-My-Zsh
antigen use oh-my-zsh

# Load various lib files
antigen bundle robbyrussell/oh-my-zsh lib/

# Theme: POWER LEVEL 9k
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k/powerlevel9k.zsh-theme
antigen theme https://github.com/bhilburn/powerlevel9k powerlevel9k
# POWERLEVEL9K_MODE='awesome-patched'

POWERLEVEL9K_DISABLE_PROMPT=true
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="red"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="red"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="blue"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs virtualenv anaconda)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Other Plugins
antigen bundle common-aliases                      # Common convenience aliases.
antigen bundle git                                 # Git aliases and completion.
antigen bundle command-not-found                   # Suggest package for missing commands.
antigen bundle extract                             # Extract many archive formats with one command.
antigen bundle tmuxinator                          # Completion/helpers for tmuxinator projects.
antigen bundle zsh-users/zsh-syntax-highlighting   # Colorize valid/invalid command syntax.
antigen bundle zsh-users/zsh-autosuggestions       # Inline suggestions from history.
antigen bundle greymd/tmux-xpanes                  # Helpers for parallel tmux pane commands.

antigen apply
####################################
# Antigen: Configuration Done
####################################

# Alias Control
source $HOME/.alias.sh

# Custom Functions
source $HOME/.functions.sh

# iterm2 integration
autoload -U compinit; compinit
