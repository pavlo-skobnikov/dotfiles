#!/usr/bin/env nu

## This script is used to (re-)stow my various dotfiles from this repository
## to target directories
## that found in the
## ../../configurations/ directory.

def stow_with_target [source, target] {
  print $"Removing stow links for `($source)` at `($target)`..."
  stow --dir $source --target $target --delete .

  print $"Stowing `($source)` at `($target)`..."
  stow --dir $source --target $target .
}

# Configuration files.
stow_with_target $"($env.HOME)/dotfiles/configurations/" $env.HOME

# Scripts.
["private-scripts" "public-scripts"] | each { |dir|
  stow_with_target $"($env.HOME)/dotfiles/scripts/($dir)" $"($env.HOME)/.local/bin"
}

# Secrets.
stow_with_target $"($env.HOME)/dotfiles/secrets" $env.HOME
