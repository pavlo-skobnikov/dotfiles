#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Neovim Anywhere: Empty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📝

# Documentation:
# @raycast.description Open a new temporary Alacritty window with an empty Neovim buffer to compose text in.
# @raycast.author paulie
# @raycast.authorURL https://raycast.com/paulie

# This script is a simplified adaptation of the `vim-anywhere` project by
# Chris Knadler. REFERENCE: https://github.com/cknadler/vim-anywhere
#
# This script quickly opens an Alacritty window with an empty Neovim buffer.
# After saving and quitting, the buffer is copied into the system clipboard for
# further usage.

# Save the currently-focused application to later switch back to it.
current_app=$(osascript -e 'tell application "System Events"' \
                         -e 'copy (name of application processes whose frontmost is true) to stdout' \
                         -e 'end tell')
# This file will hold the result text edited by Vim.
compose_file="/tmp/vim-anywhere.md"

# Make the compose file empty, optionally creating it if it doesn't exist.
> "$compose_file"

# Focus Alacritty.
osascript -e 'tell application "Alacritty" to activate'

# Create a new tmux window named "vim-anywhere", run Vim with the compose file,
# and signal completion via tmux wait-for when Neovim exits.
tmux new-window -n vim-anywhere "nvim $compose_file; tmux wait-for -S vim_finished"

# Wait for the vim_finished signal to ensure Neovim has exited.
tmux wait-for vim_finished

# Copy the edited text back to the system clipboard.
cat "$compose_file" | pbcopy

# Restore focus to the original application.
osascript -e "tell application \"$current_app\" to activate"
