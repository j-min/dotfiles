
# Vim

# Monokai color scheme
curl -fLo ~/.vim/colors/monokai.vim --create-dirs \
    https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# antigen
curl -fLo ~/.zsh/antigen.zsh --create-dirs \
    https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh

# tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# anaconda 3
if [[ $(uname -s) == Darwin ]]; then
    curl -fLo /tmp/anaconda3.sh https://repo.continuum.io/archive/Anaconda3-4.4.0-MacOSX-x86_64.sh
elif [ $(uname -s) == Linux ]; then
    curl -fLo /tmp/anaconda3.sh https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh
fi
bash /tmp/anaconda3.sh

conda config --add channels conda-forge
