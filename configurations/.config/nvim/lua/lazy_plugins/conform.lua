-- https://github.com/stevearc/conform.nvim
return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        { 'gq' },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters = {
            shfmt = {
                prepend_args = { '-i', '4' },
            },
        },
        formatters_by_ft = {
            lua = { 'stylua' },
            sh = { 'shfmt' },
            bash = { 'shfmt' },
        },
        default_format_opts = { lsp_format = 'fallback' },
        format_on_save = { timeout_ms = 500 },
    },
    init = function()
        -- Set `formatexpr` option in order to use the 'gq' action.
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
