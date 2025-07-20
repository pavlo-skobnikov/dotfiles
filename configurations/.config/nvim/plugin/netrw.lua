-- Hide the banner.
vim.g.netrw_banner = 0

-- Show previews to the right.
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0

-- Show relative line numbers in Netrw buffers.
vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

-- Change the copy command to enable recursive copy of directories.
vim.g.netrw_localcopydircmd = 'cp -r'

-- Maps.
vim.keymap.set({ 'n', 'x' }, '<Leader>e', function()
    -- Persist current opened file name.
    local fname = vim.fn.expand '%:t'

    -- Enter netrw.
    vim.cmd 'Explore'

    -- Search for the file name.
    vim.fn.search(fname, 'w')
end, { desc = 'Explore current dir' })
vim.keymap.set({ 'n', 'x' }, '<Leader>E', '<Cmd>Explore .<Cr>', { desc = 'Explore project root' })

local function map_netrw(m, lhs, rhs, desc)
    vim.keymap.set(m, lhs, rhs, {
        desc = desc,
        buffer = true,
        silent = true,
        nowait = true,
    })
end

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('SetNetrwCustomMaps', { clear = true }),
    pattern = 'netrw',
    callback = function()
        map_netrw('n', 'l', '<Plug>NetrwLocalBrowseCheck', 'Open directory/file')
        map_netrw('n', 'h', '<Plug>NetrwBrowseUpDir', 'Go up a directory')
        map_netrw('n', 'P', '<Cmd>pclose<Cr>', 'Close preview window')
        map_netrw('n', '<C-l>', '<C-l>:nohlsearch<Cr>', 'Remove highlights and refresh state')
    end,
    desc = 'Add custom Netrw maps.',
})
