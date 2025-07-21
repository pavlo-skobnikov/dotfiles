return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre', 'VeryLazy' },
    opts = {
        formatters_by_ft = {
            lua = { 'stylua' },
            sh = { 'shfmt' },
            bash = { 'shfmt' },
            toml = { 'taplo' },
        },
        default_format_opts = { lsp_format = 'fallback' },
        format_on_save = { timeout_ms = 500 },
    },
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
}
