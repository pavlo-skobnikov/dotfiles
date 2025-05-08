#!/usr/bin/env bash

## A script to Update Alacritty's current theme based on the system appearance.

if [[ -z $(defaults read -g AppleInterfaceStyle 2> /dev/null) ]]; then
    ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
else
    ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
fi

touch ~/.config/alacritty/alacritty.toml

