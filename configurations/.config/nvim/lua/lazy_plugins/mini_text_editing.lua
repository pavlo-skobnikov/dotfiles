return {
    {
        'echasnovski/mini.ai',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'echasnovski/mini.operators',
        event = 'VeryLazy',
        opts = { sort = { prefix = 'gS' } },
    },
    {
        'echasnovski/mini.surround',
        event = 'VeryLazy',
        opts = {
            mappings = {
                add = 'gsa',
                delete = 'gsd',
                replace = 'gsr',
                find = '',
                find_left = '',
                highlight = '',
                update_n_lines = '',
                suffix_last = '',
                suffix_next = '',
            },
        },
    },
    {
        'echasnovski/mini.pairs',
        event = 'VeryLazy',
        opts = {},
    },
}
