vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank { higroup = 'Visual', timeout = 250 } end,
  desc = 'Highlight the yanked text area',
})
