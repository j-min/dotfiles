#!/usr/bin/env bash
#
# ~/.install.sh — dotfiles bootstrap (shell tools, editors, Ruby, tmux, etc.)
#
# Usage:
#   bash ~/.install.sh [--force] [--sudo]
#   ~/.install.sh              # if executable: chmod +x ~/.install.sh
#
# Options:
#   --force    Run every install step even when pre-flight checks look satisfied.
#   --sudo     Use sudo for privileged Linux steps (apt/dpkg,/usr/local/bin writes).
#
# Behavior:
#   1. Prints a pre-flight installation plan (INSTALLED / MISSING / SKIP).
#   2. Runs only steps that look missing, unless --force is given.
#   3. Exits early after the plan if nothing is missing (and --force is not set).
#
# Requirements:
#   - bash (script uses bash-specific features)
#   - Network access for curl, git, brew, conda, etc.
#   - macOS: Ruby-based Homebrew installer; optional ~/.Brewfile for brew bundle
#   - Linux: use --sudo when privileged steps require elevation
#
# Predicate helpers and show_install_plan() share the same is_* checks below.

INSTALL_FORCE=false
INSTALL_USE_SUDO=false
for arg in "$@"; do
    case "$arg" in
        --force) INSTALL_FORCE=true ;;
        --sudo) INSTALL_USE_SUDO=true ;;
        -h | --help)
            cat <<'EOF'
Usage: bash ~/.install.sh [--force] [--sudo]

  --force    Run every install step even when pre-flight checks look satisfied.
  --sudo     Use sudo for privileged Linux steps (apt/dpkg,/usr/local/bin writes).

By default, only components reported MISSING in the plan are installed; if
nothing is missing, the script exits after the plan. See the header comment in
this file for requirements (bash, network, Linux privilege model, etc.).
EOF
            exit 0
            ;;
        *)
            echo "Unknown option: $arg" >&2
            echo "Usage: bash $0 [--force] [--sudo]" >&2
            exit 1
            ;;
    esac
done

UNAME_S=$(uname -s)
RUBY_VERSION='3.3.4'
# lsd-rs/lsd Linux: release tag vX.Y.Z, asset lsd-vX.Y.Z-<rust-triple>.tar.gz
LSD_VERSION='1.2.0'

have_cmd() { command -v "$1" >/dev/null 2>&1; }
have_file() { [[ -f "$1" ]]; }
have_dir() { [[ -d "$1" ]]; }
pip_has() {
    (python3 -m pip show "$1" >/dev/null 2>&1) || (pip show "$1" >/dev/null 2>&1)
}
gem_has() { have_cmd gem && gem list -i "^$1$" >/dev/null 2>&1; }

# --- Predicates (single source of truth for plan + skip logic) ---
is_antigen_installed() { have_file "$HOME/.zsh/antigen.zsh"; }
is_miniconda_installed() { have_dir "$HOME/miniconda3" || have_cmd conda; }
is_ranger_installed() { pip_has ranger-fm || have_cmd ranger; }
is_brew_installed() { have_cmd brew; }
is_vim_installed() { have_cmd vim; }
is_vim_plug_installed() { have_file "$HOME/.vim/autoload/plug.vim"; }
is_nvim_installed() { have_cmd nvim; }
is_nvim_plug_installed() { have_file "$HOME/.local/share/nvim/site/autoload/plug.vim"; }
is_pynvim_installed() { pip_has pynvim; }
is_nvim_init_present() {
    [[ -L "$HOME/.config/nvim/init.vim" ]] || [[ -f "$HOME/.config/nvim/init.vim" ]]
}
is_rbenv_present() { have_cmd rbenv || have_dir "$HOME/.rbenv"; }
is_rbenv_ruby_installed() {
    have_cmd rbenv && rbenv versions --bare 2>/dev/null | grep -qx "$RUBY_VERSION"
}
is_rbenv_global_correct() {
    have_cmd rbenv && [[ "$(rbenv global 2>/dev/null)" == "$RUBY_VERSION" ]]
}
is_tmux_installed() { have_cmd tmux; }
is_tmuxinator_installed() { gem_has tmuxinator; }
is_tpm_installed() { have_dir "$HOME/.tmux/plugins/tpm"; }
is_lsd_installed() { have_cmd lsd; }

brewfile_formulas() {
    [[ -f "$HOME/.Brewfile" ]] || return 0
    grep '^brew "' "$HOME/.Brewfile" | sed -E 's/^brew "([^"]+)".*/\1/' | sort -u
}
brewfile_casks() {
    [[ -f "$HOME/.Brewfile" ]] || return 0
    grep '^cask "' "$HOME/.Brewfile" | sed -E 's/^cask "([^"]+)".*/\1/' | sort -u
}

all_brewfile_pkgs_installed() {
    [[ -f "$HOME/.Brewfile" ]] || return 0
    is_brew_installed || return 1
    local f c
    while IFS= read -r f; do
        [[ -z "$f" ]] && continue
        brew list --formula "$f" &>/dev/null || return 1
    done < <(brewfile_formulas)
    while IFS= read -r c; do
        [[ -z "$c" ]] && continue
        brew list --cask "$c" &>/dev/null || return 1
    done < <(brewfile_casks)
    return 0
}

# True when this install step should run (force, or predicate says not yet installed).
# Usage: need_install is_antigen_installed   (predicate is true = already installed)
need_install() {
    if $INSTALL_FORCE; then return 0; fi
    if "$@"; then return 1; else return 0; fi
}

skip_msg() { echo "[install] SKIP $* (already present; use --force to run anyway)"; }

# Run a privileged command without forcing sudo by default.
run_privileged() {
    if ((EUID == 0)); then
        "$@"
    elif $INSTALL_USE_SUDO; then
        sudo "$@"
    else
        echo "[install] SKIP requires elevated privileges: $* (re-run with --sudo)"
        return 1
    fi
}

# Set by show_install_plan: count of MISSING rows (including brew/cask lines).
INSTALL_PLAN_MISSING=0

# Print planned components and whether each looks installed already.
show_install_plan() {
    local installed=0 missing=0 status name detail

    record() {
        if [[ "$1" == INSTALLED ]]; then
            installed=$((installed + 1))
        else
            missing=$((missing + 1))
        fi
    }

    echo ""
    echo "=== Installation plan (pre-flight checks) ==="
    echo ""

    name="antigen"
    detail="~/.zsh/antigen.zsh"
    if is_antigen_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="Miniconda3"
    detail='~/miniconda3 or conda on PATH'
    if is_miniconda_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="ranger-fm"
    detail='pip package / ranger command'
    if is_ranger_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    if [[ "$UNAME_S" == Darwin ]]; then
        name="Homebrew"
        detail='brew'
        if is_brew_installed; then status=INSTALLED; else status=MISSING; fi
        echo "[check] $status  $name  ($detail)"
        record "$status"

        if have_file "$HOME/.Brewfile" && is_brew_installed; then
            echo "    Brewfile formulae / casks:"
            local f c
            while IFS= read -r f; do
                [[ -z "$f" ]] && continue
                if brew list --formula "$f" &>/dev/null; then
                    echo "[check] INSTALLED    brew:$f"
                    installed=$((installed + 1))
                else
                    echo "[check] MISSING      brew:$f"
                    missing=$((missing + 1))
                fi
            done < <(brewfile_formulas)

            while IFS= read -r c; do
                [[ -z "$c" ]] && continue
                if brew list --cask "$c" &>/dev/null; then
                    echo "[check] INSTALLED    cask:$c"
                    installed=$((installed + 1))
                else
                    echo "[check] MISSING      cask:$c"
                    missing=$((missing + 1))
                fi
            done < <(brewfile_casks)
        elif [[ -f "$HOME/.Brewfile" ]]; then
            echo "[check] SKIP     Brewfile formulae/casks (install Homebrew first, then re-run to verify)"
        else
            echo "[check] SKIP     ~/.Brewfile not found (brew bundle list skipped)"
        fi
    fi

    name="vim"
    detail='vim binary'
    if is_vim_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="vim-plug (vim)"
    detail='~/.vim/autoload/plug.vim'
    if is_vim_plug_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="Neovim"
    detail='nvim binary'
    if is_nvim_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="vim-plug (nvim)"
    detail='~/.local/share/nvim/site/autoload/plug.vim'
    if is_nvim_plug_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="pynvim"
    detail='pip package for nvim Python support'
    if is_pynvim_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="nvim init.vim link"
    detail='~/.config/nvim/init.vim -> ~/.vimrc'
    if is_nvim_init_present; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="rbenv"
    detail='rbenv command or ~/.rbenv'
    if is_rbenv_present; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="Ruby $RUBY_VERSION (rbenv)"
    detail="rbenv global / versions"
    if is_rbenv_ruby_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="tmux"
    detail='tmux binary'
    if is_tmux_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="tmuxinator"
    detail='gem'
    if is_tmuxinator_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="TPM (tmux plugins)"
    detail='~/.tmux/plugins/tpm'
    if is_tpm_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    name="lsd"
    detail='lsd binary'
    if is_lsd_installed; then status=INSTALLED; else status=MISSING; fi
    echo "[check] $status  $name  ($detail)"
    record "$status"

    echo ""
    echo "=== Summary: $installed check(s) reported present, $missing reported missing ==="
    INSTALL_PLAN_MISSING=$missing
    if $INSTALL_FORCE; then
        echo "--force: all install steps will run regardless of the checks above."
    elif ((missing > 0)); then
        echo "Only components reported MISSING will be installed (use --force to run all steps)."
    else
        echo "Nothing MISSING; install steps will be skipped (use --force to run all steps)."
    fi
    echo ""
}

show_install_plan

if ! $INSTALL_FORCE && ((INSTALL_PLAN_MISSING == 0)); then
    echo "[install] Nothing to do."
    exit 0
fi

################# Zsh #################
if need_install is_antigen_installed; then
    echo "[install] Zsh: downloading antigen..."
    curl -fLo ~/.zsh/antigen.zsh --create-dirs \
        https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh
else
    skip_msg "antigen"
fi


################# Miniconda3 #################
if need_install is_miniconda_installed; then
    echo "[install] Miniconda3: downloading installer for $(uname -s)..."
    if [[ $(uname -s) == Darwin ]]; then
        curl -fLo /tmp/miniconda3_install.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
    elif [[ $(uname -s) == Linux ]]; then
        curl -fLo /tmp/miniconda3_install.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    fi
    echo "[install] Miniconda3: running installer..."
    bash /tmp/miniconda3_install.sh
else
    skip_msg "Miniconda3 (download + installer)"
fi

# Add Miniconda to PATH when present (needed for pip / ranger after skip path).
if have_dir "$HOME/miniconda3"; then
    export PATH=$HOME/miniconda3/bin:$PATH
fi

# Add conda-forge channel
# conda config --add channels conda-forge

# Conda shel initilization init
# conda init zsh

if need_install is_ranger_installed; then
    echo "[install] Miniconda3: installing ranger-fm via pip..."
    pip install ranger-fm
else
    skip_msg "ranger-fm"
fi

################# Homebrew (OsX only) #################
if [ "$(uname -s)" == Darwin ]; then
    if need_install is_brew_installed; then
        echo "[install] Homebrew: running official installer..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        skip_msg "Homebrew installer"
    fi

    if [[ -f "$HOME/.Brewfile" ]]; then
        if $INSTALL_FORCE || ! all_brewfile_pkgs_installed; then
            if is_brew_installed; then
                echo "[install] Homebrew: brew update..."
                brew update
                echo "[install] Homebrew: brew bundle from ~/.Brewfile..."
                brew bundle --file=$HOME/.Brewfile
            else
                echo "[install] SKIP brew update / bundle (Homebrew not available)"
            fi
        else
            skip_msg "brew update + brew bundle (all Brewfile packages already installed)"
        fi
    else
        echo "[install] SKIP brew update / bundle (~/.Brewfile not found)"
    fi
fi

################# Vim #################
if need_install is_vim_plug_installed; then
    echo "[install] Vim: downloading vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "[install] Vim: PlugInstall..."
    if is_vim_installed; then
        vim +PlugInstall +qall
    else
        echo "[install] SKIP vim +PlugInstall (vim not on PATH)"
    fi
else
    skip_msg "vim-plug + PlugInstall"
fi

# neovim
if [ "$(uname -s)" == Linux ]; then
    if need_install is_nvim_installed; then
        echo "[install] Neovim (Linux): downloading AppImage..."
        curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
        chmod u+x nvim.appimage
        mv ./nvim.appimage nvim
        run_privileged mv nvim /usr/local/bin
    else
        skip_msg "Neovim (Linux AppImage)"
    fi
fi
# neovim is installed via Brewfile for MacOSX

if need_install is_nvim_plug_installed; then
    echo "[install] Neovim: downloading vim-plug for nvim..."
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "[install] Neovim: PlugInstall..."
    if is_nvim_installed; then
        nvim +PlugInstall +qall
    else
        echo "[install] SKIP nvim +PlugInstall (nvim not on PATH)"
    fi
else
    skip_msg "nvim vim-plug + PlugInstall"
fi

echo "[install] Neovim: ensuring config dir..."
mkdir -p ~/.config/nvim

if need_install is_pynvim_installed; then
    echo "[install] Neovim: pip install pynvim..."
    pip install pynvim
else
    skip_msg "pynvim"
fi

# neovim config = vim config
if need_install is_nvim_init_present; then
    echo "[install] Neovim: linking ~/.vimrc -> ~/.config/nvim/init.vim..."
    ln -sf ~/.vimrc ~/.config/nvim/init.vim
else
    skip_msg "nvim init.vim link (already exists)"
fi

################# Ruby #################
if [ "$(uname -s)" == Darwin ]; then
    if $INSTALL_FORCE || ! is_rbenv_ruby_installed; then
        if is_brew_installed; then
            echo "[install] Ruby: upgrading rbenv and ruby-build (Homebrew)..."
            brew upgrade rbenv ruby-build
        else
            echo "[install] SKIP brew upgrade rbenv (Homebrew not available)"
        fi
    else
        skip_msg "brew upgrade rbenv/ruby-build"
    fi
elif [ "$(uname -s)" == Linux ]; then
    if need_install is_rbenv_present; then
        echo "[install] Ruby: cloning rbenv and plugins..."
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
        git clone https://github.com/rbenv/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
        echo "[install] Ruby: apt install build deps (libssl, readline, zlib)..."
        run_privileged apt-get install -y libssl-dev libreadline-dev zlib1g-dev
    else
        skip_msg "rbenv git clones + apt build deps"
    fi
fi

echo "[install] Ruby: sourcing ~/.path.sh..."
if [[ -f "$HOME/.path.sh" ]]; then
    # shellcheck source=/dev/null
    source "$HOME/.path.sh"
else
    echo "[install] WARN ~/.path.sh not found"
fi

if need_install is_rbenv_ruby_installed; then
    echo "[install] Ruby: rbenv install $RUBY_VERSION (this can take a while)..."
    if have_cmd rbenv; then
        rbenv install "$RUBY_VERSION"
    else
        echo "[install] SKIP rbenv install (rbenv not on PATH)"
    fi
else
    skip_msg "rbenv install $RUBY_VERSION"
fi

if $INSTALL_FORCE || ! is_rbenv_global_correct; then
    if have_cmd rbenv; then
        echo "[install] Ruby: rbenv global $RUBY_VERSION..."
        rbenv global "$RUBY_VERSION"
    else
        echo "[install] SKIP rbenv global (rbenv not on PATH)"
    fi
else
    skip_msg "rbenv global $RUBY_VERSION"
fi


################# Tmux #################
if [ "$(uname -s)" == Linux ]; then
    if need_install is_tmux_installed; then
        echo "[install] Tmux (Linux): apt install tmux..."
        run_privileged apt-get install tmux
    else
        skip_msg "tmux (apt)"
    fi
fi

if need_install is_tmuxinator_installed; then
    echo "[install] Tmuxinator: gem install --user-install..."
    gem install --user-install tmuxinator
else
    skip_msg "tmuxinator"
fi

if need_install is_tpm_installed; then
    echo "[install] Tmux: cloning TPM (plugin manager)..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    skip_msg "TPM"
fi

# lsd (Linux): official .tar.gz — no dpkg/apt required
if [ "$(uname -s)" == Linux ]; then
    if need_install is_lsd_installed; then
        lsd_target=
        case "$(uname -m)" in
            x86_64) lsd_target=x86_64-unknown-linux-gnu ;;
            aarch64|arm64) lsd_target=aarch64-unknown-linux-gnu ;;
            armv7l|armv6l) lsd_target=arm-unknown-linux-gnueabihf ;;
            i686|i386) lsd_target=i686-unknown-linux-gnu ;;
            *)
                echo "[install] lsd: unsupported machine $(uname -m); pick a build from https://github.com/lsd-rs/lsd/releases" >&2
                ;;
        esac
        if [[ -n "$lsd_target" ]]; then
            lsd_tgz="lsd-v${LSD_VERSION}-${lsd_target}.tar.gz"
            lsd_url="https://github.com/lsd-rs/lsd/releases/download/v${LSD_VERSION}/${lsd_tgz}"
            lsd_root="lsd-v${LSD_VERSION}-${lsd_target}"
            echo "[install] lsd (Linux): downloading ${lsd_tgz}..."
            lsd_tmp=$(mktemp -d)
            if curl -fsSL "$lsd_url" -o "$lsd_tmp/$lsd_tgz" &&
                tar xzf "$lsd_tmp/$lsd_tgz" -C "$lsd_tmp" &&
                [[ -x "$lsd_tmp/$lsd_root/lsd" ]]; then
                mkdir -p "$HOME/.local/bin"
                install -m 0755 "$lsd_tmp/$lsd_root/lsd" "$HOME/.local/bin/lsd"
                rm -rf "$lsd_tmp"
                echo "[install] lsd: installed ~/.local/bin/lsd (ensure ~/.local/bin is on your PATH)"
            else
                echo "[install] lsd: download or extract failed (url: $lsd_url)" >&2
                rm -rf "$lsd_tmp"
            fi
        fi
    else
        skip_msg "lsd (linux tarball)"
    fi
fi
# lsd is installed via Brewfile for MacOSX

echo "[install] Done."
