#!/usr/bin/env bash

# This script (re-)stows various dotfiles from my personal configurations
# into their respective target directories, as well as ensuring proper
# permissions are set on the script files.

echo "Chmod +x-ing scripts at [\$DOTFILES/.local/bin]..."
chmod -R +x "$DOTFILES/.local/bin/"

echo "Removing stow links for [\$DOTFILES] at [\$HOME]..."
stow --dir "$DOTFILES" --target "$HOME" --delete .

echo "Stowing [\$DOTFILES] at [\$HOME]..."
stow --dir "$DOTFILES" --target "$HOME" .
