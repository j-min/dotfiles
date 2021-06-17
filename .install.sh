
################# Zsh #################
# antigen
curl -fLo ~/.zsh/antigen.zsh --create-dirs \
    https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh


################# Anaconda 3 #################
ANACONDA_VERSION='2021.05'
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

# Ranger
pip install ranger-fm

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
if [ $(uname -s) == Linux ]; then
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x nvim.appimage
    mv ./nvim.appimage nvim
    sudo mv nvim /usr/local/bin
fi

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
mkdir -p ~/.config/nvim
pip install pynvim

# neovim config = vim config
ln -sf ~/.vimrc ~/.config/nvim/init.vim

################# Ruby #################
if [ $(uname -s) == Darwin ]; then
    brew upgrade rbenv ruby-build
elif [ $(uname -s) == Linux ]; then
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
    sudo apt-get install -y libssl-dev libreadline-dev zlib1g-dev
fi
source $HOME/.path.sh

RUBY_VERSION='2.6.3'
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION


################# Tmux #################
if [ $(uname -s) == Linux ]; then
    sudo apt-get install tmux
fi

# tmuxinator
gem install --user-install tmuxinator

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# lsd
if [ $(uname -s) == Linux ]; then
    LSD_VERSION='0.16.0'
    wget https://github.com/Peltoche/lsd/releases/download/${LSD_VERSION}/lsd_${LSD_VERSION}_amd64.deb
    sudo dpkg -i lsd_${LSD_VERSION}_amd64.deb
    rm -f lsd_${LSD_VERSION}_amd64.deb
fi
