#!/usr/bin/env bash
set -euo pipefail

# Extract the session name from a path: the last directory component, with dots
# converted to underscores.
get_session_name_from_path() {
    local path="$1"
    local current_dir="$(basename $path)"
    echo "$current_dir" | sed 's/\./_/g'
}

# Check if a tmux session with the given name exists.
is_session_with_name_present() {
    local session_name="$1"
    tmux has-session -t "$session_name" 2>/dev/null
}

# Prompt the user to pick a common project path via fzf.
select_common_path_for_session() {
    fd . ~ ~/dev/projects ~/dev/projects/work ~/dev/projects/personal \
        --min-depth 1 --max-depth 1 --type directory |
        fzf --preview '' --prompt='Select project directory > ' |
        xargs realpath
}

# Create a new session (detached) if it doesn't exist, then switch-client.
attach_or_create_session() {
    local path="$1"
    local session="$(get_session_name_from_path $path)"

    if ! is_session_with_name_present "$session"; then
        tmux new-session -ds "$session" -c "$path"
    fi

    tmux switch-client -t "$session"
}

print_help() {
    local script_name="$(basename $0)"

    cat <<EOF

    Script to quickly switch sessions and create new ones in Tmux. The script
    accepts either no arguments or a single path argument.

    If no path argument is provided, the script will prompt the user to select
    a common path via Fzf. The "common" paths are predefined in the script and
    are relevant to my personal workflow.

    If a path argument is provided, the script will create or switch to a
    session with the name being the most-nested directory name and the provided
    path.

    Usage: $script_name        # Pick a common path to switch to.
           $script_name <PATH> # Create/switch to a session for the given path.
           $script_name --help # Print this message.
EOF
}

main() {
    # Run some validations.
    if [ -z "$TMUX" ]; then
        echo "Error: not in a Tmux session"
        exit 1
    elif [[ $# -gt 1 ]]; then
        echo "Error: too many arguments"
        exit 2
    elif [[ $# -eq 1 ]]; then
        if [[ "$1" == "--help" ]]; then
            print_help
            exit 0
        elif [[ ! -d "$1" ]]; then
            echo "Error: '$1' is not a valid path."
            exit 2
        fi
    fi

    # Run the main flow.
    if [[ $# -eq 0 ]]; then
        local path="$(select_common_path_for_session)"

        if [[ -z "$path" ]]; then
            exit 1
        fi

        attach_or_create_session "$path"
    elif [[ $# -eq 1 ]]; then
        attach_or_create_session "$1"
    fi
}

main "$@"
