return {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    keys = {
        { '<Leader>gg', '<Cmd>Git<Cr>', mode = { 'n', 'v' }, desc = 'Open fugitive' },
        { '<Leader>gb', '<Cmd>Git blame<Cr>', mode = { 'n', 'v' }, desc = 'Blame' },
    },
}
