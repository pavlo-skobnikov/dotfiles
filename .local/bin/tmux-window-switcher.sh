#!/bin/bash

if [ $# -lt 1 ]; then
    cat <<EOF
    Script to create or switch to a tmux window with a specified terminal application.

    Usage: open-or-switch-tmux-window-app.sh <APPLICATION_NAME>
    Example: open-or-switch-tmux-window-app.sh 'lazygit'
EOF

    exit 1
fi

APP_NAME="$1"

# Check if we're in a tmux session.
if [ -z "$TMUX" ]; then
    echo "Error: Not in a tmux session"
    exit 1
fi

# List all windows in the session and check if one contains the app.
WINDOW_INDEX="$(tmux list-windows | grep -i "$APP_NAME" | cut -d':' -f1 | head -n1)"

if [ -n "$WINDOW_INDEX" ]; then
    # Window with the application exists, switch to it.
    tmux select-window -t "$WINDOW_INDEX"
else
    tmux new-window "$APP_NAME"
fi
