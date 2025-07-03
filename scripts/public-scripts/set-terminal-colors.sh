#!/usr/bin/env bash

## A script to dynamically update "themes" for terminal tools when the script is run.

# Fzf color definitions.
fzf_light_theme_style_part=" \
    --color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
    --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
    --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
    --color=selected-bg:#BCC0CC \
    --color=border:#CCD0DA,label:#4C4F69"
fzf_dark_theme_style_part=" \
    --color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
    --color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
    --color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
    --color=selected-bg:#51576D \
    --color=border:#414559,label:#C6D0F5"

if [[ -z $(defaults read -g AppleInterfaceStyle 2> /dev/null) ]]; then
    ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
    export FZF_DEFAULT_OPTS="$fzf_light_theme_style_part \
        $FZF_WITH_PREVIEW_OPTS"
else
    ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
    export FZF_DEFAULT_OPTS="$fzf_dark_theme_style_part \
        $FZF_WITH_PREVIEW_OPTS"
fi

# Force Alacritty to refresh configuration (and, therefore, its colors).
touch $XDG_CONFIG_HOME/alacritty/alacritty.toml
