# Dotfiles
Personal dotfile configurations

## Initial Dotfile Configurations

```
echo ".dotfiles" >> .gitignore
git clone --bare https://github.com/j-min/dotfiles $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME’
config checkout

bash .install.sh
```
