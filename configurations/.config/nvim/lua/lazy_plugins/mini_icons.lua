return {
    'echasnovski/mini.icons',
    event = 'VeryLazy',
    config = function()
        local mini_icons = require 'mini.icons'

        mini_icons.setup()
        mini_icons.mock_nvim_web_devicons()
    end,
}
