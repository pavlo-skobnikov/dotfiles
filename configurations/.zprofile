## Run some Homebrew magic.
eval "$(/opt/homebrew/bin/brew shellenv)"


## Set environment variables.
# Personal variables.
export DOTFILES=$HOME/dotfiles
export DEVSPACE=$HOME/dev
export PROJECTS=$DEVSPACE/projects
export PERSONAL_PROJECTS=$PROJECTS/personal
export WORK_PROJECTS=$PROJECTS/work

# XDG.
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/cache

# Editor.
export EDITOR='nvim'
export VISUAL='nvim'

export NVIM_LIGHT_COLORSCHEME='catppuccin-latte'
export NVIM_DARK_COLORSCHEME='catppuccin-frappe'

# Zsh-related exports.
export ZDOTDIR=$HOME
export HISTFILE=$ZDOTDIR/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000

# Basic shell configuration.
export PAGER="less"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANWIDTH=999

# Fzf configuration.
export FZF_DEFAULT_COMMAND='fd . --hidden --exclude ".git"' # Search all files except git-internal ones.

export FZF_WITH_PREVIEW_OPTS="--style=minimal \
    --layout=default
    --height 100% \
    --ansi \
    --preview-window 'right:50%' \
    --preview 'bat --color=always --style=numbers --line-range=:500 {}' \
    --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
export FZF_LIGHT_THEME_STYLE_PART=" \
    --color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
    --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
    --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
    --color=selected-bg:#BCC0CC \
    --color=border:#CCD0DA,label:#4C4F69"
export FZF_DARK_THEME_STYLE_PART=" \
    --color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
    --color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
    --color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
    --color=selected-bg:#51576D \
    --color=border:#414559,label:#C6D0F5"

# Apply Fzf defaults.
export FZF_DEFAULT_OPTS="$FZF_WITH_PREVIEW_OPTS"
export FZF_CTRL_R_OPTS="--preview=''" # Disable preview for shell history and directory searches.
export FZF_ALT_C_OPTS="--preview=''"

# SDKMan! path and managed SDKs.
export SDKMAN_DIR=$HOME/.sdkman
export JAVA_HOME=$SDKMAN_DIR/candidates/java/current
export M2_HOME=$SDKMAN_DIR/candidates/maven/current

# Set karabiner configuration path for goku.
export GOKU_EDN_CONFIG_FILE="$HOME/.config/karabiner/karabiner.edn"

# Set theme to use for bat based on system's appearance.
if [[ -z $(defaults read -g AppleInterfaceStyle 2> /dev/null) ]]; then
    export BAT_THEME="Catppuccin Latte"
else
    export BAT_THEME="Catppuccin Frappe"
fi


## Source secrets.
source ~/dotfiles/secrets/secret_exports.sh


## Manually append to $PATH.
# User-installed binaries.
path+=("$HOME/.local/bin")
# Rust-installed binaries.
path+=("$HOME/.cargo/bin")
# Rust environment.
path+=("$HOME/.cargo/env")
# Go-installed binaries.
path+=("$HOME/go/bin")
# Rust toolkit.
path+=("$HOME/.cargo/bin")
# Docker binaries.
path+=("/Applications/Docker.app/Contents/Resources/bin")
# IntelliJ IDEA.
path+=("/Applications/IntelliJ IDEA.app/Contents/MacOS")

