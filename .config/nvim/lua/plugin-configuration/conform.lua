vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    sh = { 'shfmt' },
    zsh = { 'beautysh' },
    bash = { 'shfmt' },
    toml = { 'taplo' },
  },
  default_format_opts = { lsp_format = 'fallback' },
  format_on_save = { timeout_ms = 500 },
}
