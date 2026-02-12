#!/usr/bin/env bash
set -euo pipefail

path="$1"
branch=$(git -C "$path" rev-parse --abbrev-ref HEAD 2>/dev/null)

if [[ -n "$branch" ]]; then
    echo " ($branch)"
fi
