#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Edit with Neovim
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⌨️

# Documentation:
# @raycast.description Open Neovim in a new tmux window within Ghostty to edit selected text.
# @raycast.author paulie
# @raycast.authorURL https://raycast.com/paulie

# This script is a simplified adaptation of the `vim-anywhere` project by
# Chris Knadler. REFERENCE: https://github.com/cknadler/vim-anywhere
#
# This script quickly opens a Neovim session in a new tmux window inside Ghostty,
# containing the currently selected text from another application for editing.
# After saving and quitting, the buffer is copied into the system clipboard.

# Save the currently-focused application to later switch back to it.
current_app=$(osascript -e 'tell application "System Events"' \
    -e 'copy (name of first application process whose frontmost is true) as text' \
    -e 'end tell')

# This directory will hold the result text edited by Neovim.
compose_dir="/tmp/nvim/anywhere"

# Ensure the compose directory exists.
mkdir -p "$compose_dir"

# Create a unique compose file named with the current timestamp.
compose_file="$compose_dir/$(date +'%Y-%m-%d-%H-%M-%S').md"

# Use Apple script to copy the current selection to the clipboard.
osascript -e 'tell application "System Events" to keystroke "c" using command down'

# Wait a moment to ensure the clipboard has the copied text. This is fragile
# but often works in practice.
sleep 0.1

# Focus the Ghostty application.
osascript -e 'tell application "Ghostty" to activate'

# Pipes the clipboard contents to the compose file.
pbpaste >"$compose_file"

# Create a unique signal name (incl. PID) for Tmux to avoid race conditions.
signal_name="neovim_finished_$$"

# Create a new tmux window named "nvim-anywhere", run Neovim with the compose file,
# and signal completion via tmux wait-for when Neovim exits.
tmux new-window -n nvim-anywhere -c "$(dirname "$compose_file")" \
    "nvim '$compose_file'; tmux wait-for -S '$signal_name'"

# Wait for the signal to ensure Neovim has exited.
tmux wait-for "$signal_name"

# Copy the contents of the compose file into the system clipboard.
cat "$compose_file" | pbcopy

# Switch back to the previous application.
# `open -a` is not always reliable for bringing Finder to the front.
if [ "$current_app" = "Finder" ]; then
    osascript -e 'tell application "Finder" to activate'
else
    # `open -a` is generally more reliable for other applications.
    open -a "$current_app"
fi
