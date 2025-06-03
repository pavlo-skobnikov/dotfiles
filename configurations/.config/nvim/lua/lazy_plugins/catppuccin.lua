-- https://github.com/catppuccin/nvim
return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
        require('catppuccin').setup {
            -- Flavours: latte, frappe, macchiato, mocha.
            background = { light = 'latte', dark = 'frappe' },
            -- Manually define integrations.
            -- https://github.com/catppuccin/nvim#integrations
            default_integrations = false,
            integrations = {},
        }

        -- Trigger the colorscheme.
        vim.cmd.colorscheme 'catppuccin'

        -- Correctly set `background` option based on MacOS` system appearance.
        if vim.fn.system 'defaults read -g AppleInterfaceStyle 2> /dev/null' == '' then
            vim.opt.background = 'light'
        else
            vim.opt.background = 'dark'
        end
    end,
}
