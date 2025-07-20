vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('UpdateStatusLineForActiveWindow', { clear = true }),
    pattern = '*',
    callback = function() vim.opt_local.statusline = '%t  %r%m%=%y  %l,%c    %P' end,
    desc = 'On switch to a window, set custom native statusline.',
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
    group = vim.api.nvim_create_augroup('UpdateStatusLineForInactiveWindow', { clear = true }),
    pattern = '*',
    callback = function() vim.opt_local.statusline = '%t  %r%m%=[%{winnr()}]%=%y  %l,%c    %P' end,
    desc = 'On switch away from a window, set custom native statusline.'
        .. 'Like the statusline for the active window but with a window number shown.',
})
