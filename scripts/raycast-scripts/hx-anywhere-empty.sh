#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Helix Anywhere: Empty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🧬

# Documentation:
# @raycast.description Open a new temporary Alacritty window with an empty Helix buffer to compose text in.
# @raycast.author paulie
# @raycast.authorURL https://raycast.com/paulie

# This script is a simplified adaptation of the `vim-anywhere` project by
# Chris Knadler. REFERENCE: https://github.com/cknadler/vim-anywhere
#
# This script quickly opens an Alacritty window with an empty Helix buffer.
# After saving and quitting, the buffer is copied into the system clipboard for
# further usage.

# Save the currently-focused application to later switch back to it.
current_app=$(osascript -e 'tell application "System Events"' \
                         -e 'copy (name of application processes whose frontmost is true) to stdout' \
                         -e 'end tell')
# This file will hold the result text edited by Helix.
compose_file="/tmp/hx-anywhere.md"

# Make the compose file empty, optionally creating it if it doesn't exist.
> "$compose_file"

# Focus Alacritty.
osascript -e 'tell application "Alacritty" to activate'

# Create a new tmux window named "hx-anywhere", run hx with the compose file,
# and signal completion via tmux wait-for when Helix exits.
tmux new-window -n hx-anywhere "hx $compose_file; tmux wait-for -S hx_finished"

# Wait for the hx_finished signal to ensure Helix has exited.
tmux wait-for hx_finished

# Copy the edited text back to the system clipboard.
cat "$compose_file" | pbcopy

# Restore focus to the original application.
osascript -e "tell application \"$current_app\" to activate"
