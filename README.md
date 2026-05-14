# Dotfiles
Personal dotfile configurations.

## Setup (new machine)

```bash
# 1) Clone repository metadata
git clone --bare https://github.com/j-min/dotfiles "$HOME/.dotfiles"

# 2) Make HOME behave as the work tree for this repo
printf 'gitdir: %s\n' "$HOME/.dotfiles" > "$HOME/.git"
git --git-dir="$HOME/.dotfiles" config core.bare false
git --git-dir="$HOME/.dotfiles" config core.worktree "$HOME"

# 3) Optional helper command
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# 4) Check out tracked files into HOME
dot checkout
```

## Install script

```bash
# Default: runs pre-flight checks and installs only missing components
bash "$HOME/.install.sh"

# Force: run all install steps even if already present
bash "$HOME/.install.sh" --force
```

`~/.install.sh` now:
- prints a pre-flight installation plan (`INSTALLED` / `MISSING` / `SKIP`)
- skips already installed components by default
- exits early when nothing is missing

## Cursor / Git integration

If Cursor does not show changes after setup:
1. Confirm `~/.git` contains `gitdir: /absolute/path/to/.dotfiles`.
2. Confirm `~/.dotfiles/config` has:
   - `bare = false`
   - `worktree = /Users/<you>`
3. Reload Cursor window and open the workspace at `$HOME` (or ensure repository scanning can detect parent repositories).
