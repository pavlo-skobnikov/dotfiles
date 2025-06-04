-- [[ Configuration ]]

-- Hide the banner.
vim.g.netrw_banner = 0

-- Show relative line numbers in Netrw buffers.
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

-- Keep the current directory and the browsing directory synced, avoiding the
-- move files error.
vim.g.netrw_keepdir = 0

-- Change the copy command to enable recursive copy of directories.
vim.g.netrw_localcopydircmd = 'cp -r'

-- [[ Maps ]]
vim.keymap.set('n', '-', ':Explore<CR>', { desc = 'Explore current directory', noremap = true, silent = true })
vim.keymap.set('n', '_', ':Explore ./<CR>', { desc = 'Explore project root', noremap = true, silent = true })
