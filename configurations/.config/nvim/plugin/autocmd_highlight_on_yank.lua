vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('HighlightYankedText', { clear = true }),
    pattern = '*',
    callback = function() vim.highlight.on_yank { timeout = 250 } end,
    desc = 'After yanking, highlight the yanked area for `timeout` ms value',
})
