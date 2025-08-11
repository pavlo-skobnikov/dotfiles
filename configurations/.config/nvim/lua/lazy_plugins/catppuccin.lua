return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    ---@class CatppuccinOptions
    opts = {
        background = { light = 'latte', dark = 'frappe' },
        default_integrations = false,
        integrations = {
            mason = true,
            mini = { enabled = true },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { 'italic' },
                    hints = { 'italic' },
                    warnings = { 'italic' },
                    information = { 'italic' },
                    ok = { 'italic' },
                },
                underlines = {
                    errors = { 'underline' },
                    hints = { 'underline' },
                    warnings = { 'underline' },
                    information = { 'underline' },
                    ok = { 'underline' },
                },
                inlay_hints = {
                    background = true,
                },
            },
            telescope = true,
            treesitter = true,
        },
    },
    config = function(_, opts)
        -- Make background of float windows the same as the regular editor background.
        vim.api.nvim_create_autocmd('ColorScheme', {
            callback = function() vim.api.nvim_set_hl(0, 'NormalFloat', { link = 'Normal' }) end,
        })

        require('catppuccin').setup(opts)

        vim.cmd 'colorscheme catppuccin'

        -- Set theme based on MacOS' current System Appearance setting.
        if vim.fn.system 'defaults read -g AppleInterfaceStyle 2> /dev/null' == '' then
            vim.opt.background = 'light'
        else
            vim.opt.background = 'dark'
        end
    end,
}
