vim.api.nvim_create_autocmd('CursorHold', {
  callback = function() vim.lsp.buf.document_highlight() end,
  desc = 'Highlight symbol under cursor',
  buffer = 0,
})

vim.api.nvim_create_autocmd('CursorHoldI', {
  callback = function() vim.lsp.buf.document_highlight() end,
  desc = 'Highlight symbol under cursor in insert mode',
  buffer = 0,
})

vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function() vim.lsp.buf.clear_references() end,
  desc = 'Clear symbol highlights',
  buffer = 0,
})
