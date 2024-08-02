local inlay_hint = vim.lsp.inlay_hint

vim.api.nvim_create_user_command(
  'ToggleInlayHints',
  function() inlay_hint.enable(not inlay_hint.is_enabled()) end,
  { desc = 'Toggles inlay hints provided by the language server' }
)
