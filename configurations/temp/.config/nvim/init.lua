-- Source common options for Neovim and IdeaVim.
--   - <LEADER> key definition;
--   - basic options available in Neovim and IdeaVim;
--   - basic remaps.
vim.cmd.source('~/.config/nvim/common.vim')

-- Define and <LOCALLEADER> keys.
vim.g.maplocalleader = "\\"

-- Import the Neovim-specific basic configurations module:
--   - extra options, which aren't applicable to/required for Neovim;
--   - Lazy plugin manager configuration.
require 'config'
