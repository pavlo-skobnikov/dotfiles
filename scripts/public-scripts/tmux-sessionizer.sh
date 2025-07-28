#!/usr/bin/env bash

# This script provides functionality to create and/or switch to `tmux`
# sessions quickly. 2 entry points exist for the script with the following
# differing functionalities:
#   - tmux-sessionizer.sh [ABSOLUTE_PATH]: Providing an absolute path as the
#       argument to the script, the script either creates a session with
#       the name being the most-nested directory name and the provided path
#       being the session root or simply switches to an existing session with
#       the matching session name.
#   - tmux-sessionizer.sh common-paths: Fuzzy select a directory path from a
#       predefined set of directories and create/switch to a corresponding
#       tmux session following the logic described above.

# Extract the session name from a path: the last directory component,
# with dots converted to underscores.
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

    if ! is_active_session_present "$session"; then
        tmux new-session -ds "$session" -c "$path"
    fi

    tmux switch-client -t "$session"
}

main() {
    if [[ $# -gt 0 && "$1" == "common-paths" ]]; then
        local path="$(select_common_path_for_session)"

        if [[ -z "$path" ]]; then
            exit 1
        fi

        attach_or_create_session "$path"
    elif [[ $# -gt 0 ]]; then
        attach_or_create_session "$1"
    else
        echo "Usage: $0 <PATH>        # create/switch by path"
        echo "       $0 common-paths  # pick path via fzf"
        exit 2
    fi
}

main "$@"
