#!/usr/bin/env bash

# NOTE: Before running this script, the Github SSH key must be set up for the
# given device.

# This script is used to setup any MacOS machine as my development environment.
#
# HINT: This script can be run w/o pulling the repository w/ the following
# command: bash <(curl -s https://raw.githubusercontent.com/pavlo-skobnikov/dotfiles/refs/heads/main/.setup/setup.sh)

# Firstly, let's install Homebrew to manage our packages.
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone my dotfiles repository.
git clone --recurse-submodules git@github.com:pavlo-skobnikov/dotfiles.git ~/dotfiles

# Source my usual shell environment.
source ~/dotfiles/.zprofile

# Install basic environment tools.
brew bundle install --file=~/dotfiles/.config/.setup/Brewfile

# Setup dotfiles and scripts.
/bin/bash ~/dotfiles/.local/bin/stow-and-chmod-dotfiles.sh

# Set some MacOS options.
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g NSWindowShouldDragOnGesture -bool true
