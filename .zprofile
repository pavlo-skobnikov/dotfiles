## Run some Homebrew magic 🧙
eval "$(/opt/homebrew/bin/brew shellenv)"


## Set environment variables.
# Personal variables.
export DOTFILES="$HOME/dotfiles"
export DEVSPACE="$HOME/dev"
export PROJECTS_DIR="$DEVSPACE/projects"
export PERSONAL_PROJECTS="$PROJECTS_DIR/personal"
export WORK_PROJECTS="$PROJECTS_DIR/work"

# XDG.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.local/cache"

# Editor.
export EDITOR='nvim'
export VISUAL='nvim'

# Zsh-related exports.
export ZDOTDIR="$HOME"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# Basic shell configuration.
export PAGER='less'
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Fzf configuration.
export FZF_DEFAULT_COMMAND='fd . --hidden --exclude ".git"'
export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/config"

export FZF_BAT_PREVIEW_PART='bat --color=always --style=numbers --line-range=:500 {}'
export FZF_EZA_PREVIEW_PART='eza --color=always --icons=always --oneline --all {}'
export FZF_BAT_OR_EZA_PREVIEW_PART="if [ -d {} ]; then $FZF_EZA_PREVIEW_PART; else $FZF_BAT_PREVIEW_PART; fi"

export FZF_CTRL_T_OPTS="--preview '$FZF_BAT_OR_EZA_PREVIEW_PART'"

export FZF_ALT_C_COMMAND=
export FZF_ALT_C_OPTS="--preview '$FZF_EZA_PREVIEW_PART'"

# SDKMan! path and managed SDKs.
export SDKMAN_DIR="$HOME/.sdkman"
export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
export M2_HOME="$SDKMAN_DIR/candidates/maven/current"

# NVM.
export NVM_DIR="$HOME/.nvm"

# Set karabiner configuration path for goku.
export GOKU_EDN_CONFIG_FILE="$HOME/.config/karabiner/karabiner.edn"


## Source secrets.
source ~/.secrets/secret_exports.sh


## $PATH shenanigans:
# -> prepend to $PATH.
# GNU utils 🔛🔝
path=('/opt/homebrew/opt/coreutils/libexec/gnubin' $path)

# -> append to $PATH.
# User-installed binaries & scripts.
path+=("$HOME/.local/bin")
# My secret binaries.
path+=("$HOME/.secrets/bin")
# Rust-installed binaries.
path+=("$HOME/.cargo/bin")
# Rust environment.
path+=("$HOME/.cargo/env")
# Go-installed binaries.
path+=("$HOME/go/bin")
# Rust toolkit.
path+=("$HOME/.cargo/bin")
# Docker binaries.
path+=('/Applications/Docker.app/Contents/Resources/bin')
# IntelliJ IDEA.
path+=('/Applications/IntelliJ IDEA.app/Contents/MacOS')
# nvm's node binaries manually symlinked.
path+=("$NVM_DIR/current")

