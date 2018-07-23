
################# Vim #################

# Monokai color scheme
curl -fLo ~/.vim/colors/monokai.vim --create-dirs \
    https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

################# Zsh #################

# antigen
curl -fLo ~/.zsh/antigen.zsh --create-dirs \
    https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh

################# Tmux #################

# tmuxinator
gem install --user-install tmuxinator

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

################# Anaconda 3 #################
VERSION='5.2.0'
if [ $(uname -s) == Darwin ]; then
    curl -fLo /tmp/anaconda3.sh https://repo.continuum.io/archive/Anaconda3-$VERSION-MacOSX-x86_64.sh
elif [ $(uname -s) == Linux ]; then
    curl -fLo /tmp/anaconda3.sh https://repo.continuum.io/archive/Anaconda3-$VERSION-Linux-x86_64.sh
fi
bash /tmp/anaconda3.sh

# Add Anaconda to PATH
export PATH=$HOME/anaconda3/bin:$PATH

# Add conda-forge channel
conda config --add channels conda-forge
