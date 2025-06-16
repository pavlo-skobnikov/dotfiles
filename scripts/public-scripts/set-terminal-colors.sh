#!/usr/bin/env bash

## A script to dynamically update "themes" for terminal tools when the script is run.

# Bat theme definitions.
bat_light_theme="gruvbox-light"
bat_dark_theme="gruvbox-dark"

# Fzf color definitions.
fzf_light_theme_style_part=" \
    --color=bg+:#ebdbb2,bg:#f9f5d7,spinner:#427b58,hl:#076678 \
    --color=fg:#665c54,header:#076678,info:#b57614,pointer:#427b58 \
    --color=marker:#427b58,fg+:#3c3836,prompt:#b57614,hl+:#076678"
fzf_dark_theme_style_part=" \
    --color=bg+:#3c3836,bg:#32302f,spinner:#8ec07c,hl:#83a598 \
    --color=fg:#bdae93,header:#83a598,info:#fabd2f,pointer:#8ec07c \
    --color=marker:#8ec07c,fg+:#ebdbb2,prompt:#fabd2f,hl+:#83a598"

if [[ -z $(defaults read -g AppleInterfaceStyle 2> /dev/null) ]]; then
    ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
    export BAT_THEME="$bat_light_theme"
    export FZF_DEFAULT_OPTS="$fzf_light_theme_style_part \
        $FZF_WITH_PREVIEW_OPTS"
else
    ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
    export BAT_THEME="$bat_dark_theme"
    export FZF_DEFAULT_OPTS="$fzf_dark_theme_style_part \
        $FZF_WITH_PREVIEW_OPTS"
fi

# Force Alacritty to refresh configuration (and, therefore, its colors).
touch ~/.config/alacritty/alacritty.toml
