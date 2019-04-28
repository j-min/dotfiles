
################# Zsh #################
# antigen
curl -fLo ~/.zsh/antigen.zsh --create-dirs \
    https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh


################# Anaconda 3 #################
VERSION='2019.03'
if [ $(uname -s) == Darwin ]; then
    curl -fLo /tmp/anaconda3.sh https://repo.anaconda.com/archive/Anaconda3-$VERSION-MacOSX-x86_64.sh
elif [ $(uname -s) == Linux ]; then
    curl -fLo /tmp/anaconda3.sh https://repo.anaconda.com/archive/Anaconda3-$VERSION-Linux-x86_64.sh
fi

bash /tmp/anaconda3.sh

# Add Anaconda to PATH
export PATH=$HOME/anaconda3/bin:$PATH

# Add conda-forge channel
# conda config --add channels conda-forge


################# Homebrew (OsX only) #################
if [ $(uname -s) == Darwin ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update
    brew bundle --file=$HOME/.Brewfile
fi



################# Vim #################
# Monokai color scheme
curl -fLo ~/.vim/colors/monokai.vim --create-dirs \
    https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall


################# Ruby #################
if [ $(uname -s) == Darwin ]; then
    brew upgrade rbenv ruby-build
elif [ $(uname -s) == Linux ]; then
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
fi
source $HOME/.path.sh

VERSION='2.6.3'
rbenv install $VERSION
rbenb global $VERSION


################# Tmux #################
if [ $(uname -s) == Darwin ]; then
    # tmux 2.8.1 for tmuxinator compatibility
    SHA=b3bd700d9fc53fa153c884b0ea613822de1f375c
    brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/$SHA/Formula/tmux.rb
    # brew install tmux <= tmux 2.9
elif [ $(uname -s) == Linux ]; then
    sudo apt-get install tmux
fi

# tmuxinator
gem install --user-install tmuxinator

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
