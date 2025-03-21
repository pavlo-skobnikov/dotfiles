#!/usr/bin/env bash

# NOTE: Before running this script, the Github SSH key must be set up for the
# given device.

# This script is used to setup any MacOS machine as my development environment.
#
# HINT: This script can be run w/o pulling the repository w/ the following
# command: bash <(curl -s https://raw.githubusercontent.com/pavlo-skobnikov/dotfiles/refs/heads/main/setup/setup.sh)

# Firstly, let's install Homebrew to manage our packages.
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to the current shell's path.
echo >> ~/.zprofile
echo "eval \"$(/opt/homebrew/bin/brew shellenv)\"" >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Clone my dotfiles repository.
git clone git@github.com:pavlo-skobnikov/dotfiles.git

# Install basic environment tools.
brew bundle install --file=~/dotfiles/setup/setup.brewfile

# Chmod my scripts.
chmod -R +x ~/dotfiles/scripts/public-scripts/
chmod -R +x ~/dotfiles/scripts/private-scripts/
chmod -R +x ~/dotfiles/scripts/raycast-scripts/

# Stow my dotfiles and symlink scripts.
/opt/homebrew/bin/nu ~/dotfiles/scripts/public-scripts/stow-dotfiles.nu

# Set some MacOS options.
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g NSWindowShouldDragOnGesture -bool true

