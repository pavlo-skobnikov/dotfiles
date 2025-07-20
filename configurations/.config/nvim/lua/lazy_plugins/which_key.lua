return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    ---@class wk.Opts
    opts = {
        preset = 'helix',
        delay = 0,
        icons = { mappings = false },
    },
    config = function(_, opts)
        local which_key = require 'which-key'

        which_key.setup(opts)

        vim.api.nvim_create_user_command(
            'ShowBufferLocalKeymaps',
            function() which_key.show { global = false } end,
            { desc = 'Activates which-key pop-up and with buffer-local keymaps.' }
        )
    end,
}
