#!/usr/bin/env bash

## A script to Update Alacritty's current theme based on the system appearance.
## A script to dynamically update "themes" for terminal tools when the script is run.

fzf_theme_style_part=''

if [[ -z $(defaults read -g AppleInterfaceStyle 2> /dev/null) ]]; then
    ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
    fzf_theme_style_part="$FZF_LIGHT_THEME_STYLE_PART"
else
    ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
    fzf_theme_style_part="$FZF_DARK_THEME_STYLE_PART"
fi

# Force Alacritty to refresh configuration (and, therefore, its colors).
touch ~/.config/alacritty/alacritty.toml

# Reapply Fzf default options with a new theme.
export FZF_DEFAULT_OPTS="$fzf_theme_style_part \
    $FZF_WITH_PREVIEW_OPTS"

