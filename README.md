# Dotfiles
Personal dotfile configurations

## Initial Dotfile Configurations

```
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/j-min/dotfiles $HOME/.dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot checkout

bash .install.sh
```
