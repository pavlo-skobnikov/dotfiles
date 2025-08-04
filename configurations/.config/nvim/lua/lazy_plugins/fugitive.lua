return {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    keys = {
        { '<Leader>gg', '<Cmd>Git<Cr>', desc = 'Open fugitive' },
        { '<Leader>gb', '<Cmd>Git blame<Cr>', desc = 'Blame' },
    },
}
