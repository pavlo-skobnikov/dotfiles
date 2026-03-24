#!/bin/bash

set -euo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Edit with Helix
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🧬

# Documentation:
# @raycast.description Open Helix in Tmux within Ghostty to edit selected text.
# @raycast.author paulie
# @raycast.authorURL https://raycast.com/paulie

# This script is a simplified adaptation of the `vim-anywhere` project by
# Chris Knadler. REFERENCE: https://github.com/cknadler/vim-anywhere
#
# This script opens a tmux session called "hx-anywhere", creates a temporary
# file in the "/tmp/hx/anywhere" directory with the currently
# selected text, and starts Helix in that file. After editing, it pipes the
# contents of the file back into the system clipboard and switches back to the
# originally focused application when starting this script.

# The directory to store edit files across editing script runs.
edit_files_path="/tmp/hx/anywhere"

# A unique edit ID for the current script run => basically a timestamp.
edit_id="$(date -u +%Y_%m_%dT%H_%M_%SZ)"

# The path to the edit file for the current script run.
edit_file="$edit_files_path/$edit_id.md"

# Ensure the compose directory exists.
mkdir -p "$edit_files_path"

# Save the currently focused application to restore it later after finishing the edit.
focused_app=$(osascript -e 'tell application "System Events" to get name of (first process whose frontmost is true)')

# Copy the current selection to the clipboard by triggering `Command+c`.
osascript -e 'tell application "System Events" to keystroke "c" using command down' &
sleep 0.2

# Focus Ghostty.
osascript -e 'tell application "Ghostty" to activate'

# Pipes the clipboard contents to the compose file.
pbpaste >"$edit_file"

# Create or switch to the hx-anywhere session.
session="hx-anywhere"
if ! tmux has-session -t "$session" 2>/dev/null; then
    tmux new-session -ds "$session" -c "$edit_files_path"
else
    tmux switch-client -t "$session"
fi

# Create a new tmux window named "hx-anywhere", run Helix with the compose file,
# and signal completion via tmux wait-for when Helix exits.
signal_name="hx_anywhere_finished__$edit_id"
tmux new-window -n "$edit_id" "hx '$edit_file'; tmux wait-for -S '$signal_name'"

# Wait for the signal to ensure Helix has exited.
tmux wait-for "$signal_name"

# Copy the contents of the compose file into the system clipboard.
cat "$edit_file" | pbcopy

# Restore focus to the originally focused application.
osascript -e "tell application \"$focused_app\" to activate"

# Switch back to the previous session in tmux.
tmux switch-client -l
