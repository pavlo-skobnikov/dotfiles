#!/bin/bash
set -euo pipefail

print_help() {
    local script_name="$(basename $0)"

    cat <<EOF

    Script to create or switch to a tmux window with a specified terminal application.

    Usage: $script_name <APPLICATION_NAME> # Create/switch to a Tmux window with the given tool.
           $script_name --help             # Print this message.

    Example: $script_name 'lazygit'
EOF
}

# Run some validations.
if [ -z "$TMUX" ]; then
    echo "Error: not in a Tmux session"
    exit 2
elif [[ $# -lt 1 ]]; then
    echo "Error: not enough arguments"
    exit 2
elif [[ $# -gt 1 ]]; then
    echo "Error: too many arguments"
    exit 2
fi

# Print help if requested.
if [ "$1" == "--help" ]; then
    print_help
    exit 0
fi

app_name="$1"

# List all windows in the session and check if one contains the app.
window_index="$(tmux list-windows | grep -i "$app_name" | cut -d':' -f1 | head -n1 2>/dev/null || true)"

# Switch to or create the Tmux window.
if [ -n "$window_index" ]; then
    tmux select-window -t "$window_index"
else
    tmux new-window "$@"
fi
