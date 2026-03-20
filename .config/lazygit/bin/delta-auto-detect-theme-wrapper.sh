#!/usr/bin/env bash

if [ -z $(defaults read -g AppleInterfaceStyle 2>/dev/null) ]; then
    delta --light --syntax-theme='catppuccin-latte' "$@"
else
    delta --dark --syntax-theme='catppuccin-frappe' "$@"
fi
