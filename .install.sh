
################# Zsh #################
# antigen
curl -fLo ~/.zsh/antigen.zsh --create-dirs \
    https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh


################# Anaconda 3 #################
ANACONDA_VERSION='2019.03'
if [[ $(uname -s) == Darwin ]]; then
    curl -fLo /tmp/anaconda3.sh https://repo.anaconda.com/archive/Anaconda3-$ANACONDA_VERSION-MacOSX-x86_64.sh
elif [[ $(uname -s) == Linux ]]; then
    curl -fLo /tmp/anaconda3.sh https://repo.anaconda.com/archive/Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh
fi

bash /tmp/anaconda3.sh

# Add Anaconda to PATH
export PATH=$HOME/anaconda3/bin:$PATH

# Add conda-forge channel
# conda config --add channels conda-forge

# Conda shel initilization init
conda init zsh

################# Homebrew (OsX only) #################
if [ $(uname -s) == Darwin ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    brew bundle --file=$HOME/.Brewfile
fi



################# Vim #################
# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall

################# Ruby #################
if [ $(uname -s) == Darwin ]; then
    brew upgrade rbenv ruby-build
elif [ $(uname -s) == Linux ]; then
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
fi
source $HOME/.path.sh

RUBY_VERSION='2.6.3'
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION


################# Tmux #################
if [ $(uname -s) == Darwin ]; then
    # tmux 2.8.1 for tmuxinator compatibility
    TMUX_SHA=b3bd700d9fc53fa153c884b0ea613822de1f375c
    brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/$TMUX_SHA/Formula/tmux.rb
    # brew install tmux <= tmux 2.9
elif [ $(uname -s) == Linux ]; then
    sudo apt-get install tmux
fi

# tmuxinator
gem install --user-install tmuxinator

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
