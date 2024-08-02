-- Open the diagnostics float when jumping to a diagnostic.
vim.diagnostic.config { jump = { float = true } }

-- Enable language servers.
vim.lsp.enable {
  'lua_ls',
  'bashls',
  'taplo',
}
