-- Sane configuration for Netrw.
vim.cmd([[
  " Hide the banner.
  let g:netrw_banner = 0
  " Use the tree view.
  let g:netrw_liststyle = 3
  " Show relative numbers in Netrw.
  let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
  " Keep the current directory and the browsing directory synced, avoiding the
  " move files error.
  let g:netrw_keepdir = 0
  " Change the size of the Netrw window when it creates a split from 50% to 30%.
  let g:netrw_winsize = 70
  " Change the copy command to enable recursive copy of directories.
  let g:netrw_localcopydircmd = 'cp -r'
]])

-- Access Netrw maps.
vim.keymap.set('n', '-', ':Explore<CR>', { silent = true, desc = 'Select current file in Netrw' })
vim.keymap.set('n', '_', ':Explore ./<CR>', { silent = true, desc = 'Open project root in Netrw' })
