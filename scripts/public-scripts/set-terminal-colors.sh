#!/usr/bin/env bash

## A script to dynamically update "themes" for terminal tools when the script is run.

if [[ -z $(defaults read -g AppleInterfaceStyle 2>/dev/null) ]]; then
    ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
else
    ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
fi

# Force Alacritty to refresh configuration (and, therefore, its colors).
touch $XDG_CONFIG_HOME/alacritty/alacritty.toml
