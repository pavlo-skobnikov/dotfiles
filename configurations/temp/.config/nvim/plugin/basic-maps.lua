-- This file contains miscellaneous basic maps that are specific to Neovim.

-- Evaluate Lua w/ Neovim's Lua runtime.
vim.keymap.set('n', '<LEADER>ie', ':%lua<CR>', { silent = true, desc = 'Eval entire buffer w/ Lua runtime' })
vim.keymap.set('v', '<LEADER>ie', ':lua<CR>', { silent = true, desc = 'Eval selection w/ Lua runtime' })
