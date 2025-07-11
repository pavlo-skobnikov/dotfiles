return {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    opts = {
        -- Flavour: latte, frappe, macchiato, mocha.
        background = { light = 'latte', dark = 'frappe' },
        -- Manually define integrations.
        default_integrations = false,
        integrations = {
            gitsigns = true,
            mason = true,
            native_lsp = { enabled = true },
            telescope = { enabled = true },
            which_key = true,
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
