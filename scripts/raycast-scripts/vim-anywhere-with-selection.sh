#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Neovim Anywhere: With Selection
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
# This script quickly opens an Alacritty window with a Neovim buffer containing
# the currently selected text from another application for editing. After saving
# and quitting, the buffer is copied into the system clipboard for further
# usage.

# Save the currently-focused application to later switch back to it.
current_app=$(osascript -e 'tell application "System Events"' \
                         -e 'copy (name of application processes whose frontmost is true) to stdout' \
                         -e 'end tell')
# This file will hold the result text edited by Neovim.
compose_file="/tmp/vim-anywhere.md"

# Use osascript to copy the current selection to the clipboard.
osascript -e 'tell application "System Events" to keystroke "c" using command down'

# Wait a moment to ensure the clipboard has the copied text.
sleep 0.1

# Pipes the clipboard contents to the compose file, optionally creating it if it
# doesn't exist.
pbpaste > "$compose_file"

# Focus Alacritty.
osascript -e 'tell application "Alacritty" to activate'

# Create a new tmux window named "vim-anywhere", run Neovim with the compose file,
# and signal completion via tmux wait-for when Neovim exits.
tmux new-window -n vim-anywhere "nvim $compose_file; tmux wait-for -S vim_finished"

# Wait for the vim_finished signal to ensure Neovim has exited.
tmux wait-for vim_finished

# Copy the edited text back to the system clipboard.
cat "$compose_file" | pbcopy

# Restore focus to the original application.
osascript -e "tell application \"$current_app\" to activate"
