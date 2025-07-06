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
export EDITOR="vim"
export VISUAL="vim"

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
export FZF_DEFAULT_OPTS_FILE="$HOME/.fzfrc"
export FZF_CTRL_R_OPTS="--preview ''"                       # Disable preview for shell history and directory searches.
export FZF_ALT_C_OPTS="--preview ''"

# SDKMan! path and managed SDKs.
export SDKMAN_DIR=$HOME/.sdkman
export JAVA_HOME=$SDKMAN_DIR/candidates/java/current
export M2_HOME=$SDKMAN_DIR/candidates/maven/current

# NVM.
export NVM_DIR="$HOME/.nvm"

# Set karabiner configuration path for goku.
export GOKU_EDN_CONFIG_FILE="$HOME/.config/karabiner/karabiner.edn"

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

