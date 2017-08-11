
# Vim
# Monokai color scheme
mkdir -p ~/.vim/colors
wget https://raw.githubusercontent.com/crusoexia/vim-monokai/master/colors/monokai.vim -P ~/.vim/colors

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# antigen
mkdir -p ~/.zsh
curl -qL https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh > ~/.zsh/antigen.zsh
