#!/usr/bin/env bash

## A script to dynamically update "themes" for terminal tools when the script is run.

nvim_background=''

if [[ -z $(defaults read -g AppleInterfaceStyle 2>/dev/null) ]]; then
    ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
    nvim_background='light'
else
    ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
    nvim_background='dark'
fi

# Force Alacritty to refresh configuration (and, therefore, its colors).
touch $XDG_CONFIG_HOME/alacritty/alacritty.toml

# Update the terminal colors in all Neovim server instances.
if [ -d /tmp/nvim ]; then
    fd . /tmp/nvim --exec nvim --server {} --remote-send "<Cmd>set background=$nvim_background<Cr>"
fi
