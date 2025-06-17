#!/usr/bin/env bash

# This script (re-)stows various dotfiles from my personal configurations
# into their respective target directories.

# Log a message with a timestamp.
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Remove existing stow links, then stow the source into the target.
stow_with_target() {
  local source_dir="$1"
  local target_dir="$2"

  log "Removing stow links for '${source_dir}' at '${target_dir}'..."
  stow --dir "${source_dir}" --target "${target_dir}" --delete .

  log "Stowing '${source_dir}' at '${target_dir}'..."
  stow --dir "${source_dir}" --target "${target_dir}" .
}

# 1. Configuration files.
stow_with_target "$DOTFILES/configurations" "$HOME"

# 2. Scripts.
stow_with_target "$DOTFILES/scripts/public-scripts" "$HOME/.local/bin"
stow_with_target "$DOTFILES/scripts/private-scripts" "$HOME/.local/bin"

# 3. Secrets.
stow_with_target "$DOTFILES/secrets" "$HOME"
