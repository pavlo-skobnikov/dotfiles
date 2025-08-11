return {
    'Exafunction/windsurf.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'VeryLazy',
    keys = { { '<Leader>c', '<Cmd>Codeium Chat<Cr>', mode = { 'n', 'v' }, desc = 'Open Windsurf chat' } },
    opts = {
        enable_cmp_source = false,
        virtual_text = {
            enabled = true,
            key_bindings = {
                accept_word = '<M-Right>',
                accept_line = '<A-Right>',
                accept = '<S-Right>',
                clear = '<M-Left>',
                next = '<M-Down>',
                prev = '<M-Up>',
            },
        },
    },
    config = function(_, opts) require('codeium').setup(opts) end,
}
