vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down and center', noremap = true, silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up and center', noremap = true, silent = true })

vim.keymap.set('n', 'R', ':%s/', { desc = 'Substitute in buffer', noremap = true, silent = true })
vim.keymap.set('v', 'R', ':s/', { desc = 'Substitute in selection', noremap = true, silent = true })

vim.keymap.set('n', 'ga', ':%normal', { desc = 'Execute :normal for buffer', noremap = true, silent = true })
vim.keymap.set('v', 'ga', ':normal', { desc = 'Execute :normal in selection', noremap = true, silent = true })

vim.keymap.set('n', 'gs', '"+', { desc = 'Use system register', noremap = true, silent = true })
vim.keymap.set('n', 'gb', '"_', { desc = 'Use blackhole register', noremap = true, silent = true })
