#!/bin/bash

# Save the currently-focused application to later switch back to it.
current_app=$(osascript -e 'tell application "System Events"' \
    -e 'copy (name of application processes whose frontmost is true) to stdout' \
    -e 'end tell')

# This file will hold the result text edited by Neovim.
compose_file="/tmp/nvim-anywhere.md"

# Pipes the clipboard contents to the compose file, optionally creating it if it
# doesn't exist.
pbpaste >"$compose_file"

# Focus the Ghostty application.
osascript -e 'tell application "Ghostty" to activate'

# Create a new tmux window named "nvim-anywhere", run Neovim with the compose file,
# and signal completion via tmux wait-for when Neovim exits.
tmux new-window -n nvim-anywhere "hx $compose_file; tmux wait-for -S nvim_finished"

# Wait for the nvim_finished signal to ensure Neovim has exited.
tmux wait-for nvim_finished

# Copy the contents of the compose file into the system clipboard.
<"$compose_file" pbcopy

# Switch back to the previous application.
osascript -e "tell application \"$current_app\" to activate"
