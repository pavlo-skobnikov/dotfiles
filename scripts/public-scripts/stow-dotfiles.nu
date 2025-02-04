#!/usr/bin/env nu

use std/dirs

# Add directory w/ public scripts to the the directory stack.
dirs add ~/dotfiles/configurations

ls | filter { $in.type == dir } | get name | each { 
  print $"Removing stow links for ($in)..."
  stow -t $env.HOME -D $in

  print $"Stowing ($in)..."
  stow -t $env.HOME $in
}

# Clean up the directory stack.
dirs drop
