#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Vim Anywhere: Empty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📝

# Documentation:
# @raycast.description Open a new temporary Alacritty window with an empty Vim buffer to compose text in.
# @raycast.author paulie
# @raycast.authorURL https://raycast.com/paulie

# This script is a simplified adaptation of the `vim-anywhere` project by
# Chris Knadler. REFERENCE: https://github.com/cknadler/vim-anywhere
#
# This script quickly opens an Alacritty window with an empty Vim buffer.
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

# Edit the compose file with Vim.
alacritty -e /opt/homebrew/bin/nu -c "vim $compose_file" &

# Get the PID of the Alacritty process.
alacritty_pid=$!

# Wait for 100 milliseconds.
sleep 0.25

# Move the window to the bottom half of the screen.
open -g raycast://extensions/raycast/window-management/bottom-half &

# Wait for the Alacritty process to finish.
wait $alacritty_pid

# Copy the contents of the compose file into the system clipboard.
cat "$compose_file" | pbcopy

# Switch back to the previous application.
osascript -e "tell application \"$current_app\" to activate"
