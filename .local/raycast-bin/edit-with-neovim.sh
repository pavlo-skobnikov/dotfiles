#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Edit with Neovim

# Optional parameters:
# @raycast.icon ⌨️

# Documentation:
# @raycast.description Open Neovim in a new Alacritty window to edit selected text.
# @raycast.author paulie
# @raycast.authorURL https://raycast.com/paulie
# @raycast.mode silent

# This script is a simplified adaptation of the `vim-anywhere` project by
# Chris Knadler. REFERENCE: https://github.com/cknadler/vim-anywhere

# The directory to store edit files across editing script runs.
edit_files_path="/tmp/nvim/anywhere"

# A unique edit ID for the current script run => basically a timestamp.
edit_id="$(date -u +%Y_%m_%dT%H_%M_%SZ)"

# The path to the edit file for the current script run.
edit_file="$edit_files_path/$edit_id.md"

# Ensure the compose directory exists.
mkdir -p "$edit_files_path"

# Save the currently focused application to restore it later after finishing the edit.
focused_app=$(osascript -e 'tell application "System Events" to get name of (first process whose frontmost is true)')

# Copy the current selection to the clipboard by triggering `Command + C`.
osascript -e 'tell application "System Events" to keystroke "c" using command down' &
sleep 0.2

# Pipes the clipboard contents to the compose file.
pbpaste >"$edit_file"

# Open a new Alacritty window w/ Neovim.
alacritty --title "nvim-anywhere from $focused_app" --command zsh --login -c "nvim $edit_file"

# Copy the contents of the compose file into the system clipboard.
cat "$edit_file" | pbcopy

# Restore focus to the originally focused application.
osascript -e "tell application \"$focused_app\" to activate"
