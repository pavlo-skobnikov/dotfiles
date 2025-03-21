#!/bin/sh

## This script replaces the symbolic link for Alacritty's used theme and force
## reloads Alacritty's configuration.

# NOTE: If MacOS' System Appearance is dark then `Dark` string is returned.
SYSTEM_APPEARANCE=$(defaults read -g AppleInterfaceStyle 2> /dev/null)

if [ "$SYSTEM_APPEARANCE" = "Dark" ]
then
  ln -fs ~/.config/alacritty/dark_theme.toml ~/.config/alacritty/_active_theme.toml
else
  ln -fs ~/.config/alacritty/light_theme.toml ~/.config/alacritty/_active_theme.toml
fi

# Reload Alacritty's configuration.
touch ~/.config/alacritty/alacritty.toml

