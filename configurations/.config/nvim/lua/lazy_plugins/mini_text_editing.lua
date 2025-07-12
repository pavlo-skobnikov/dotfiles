return {
    {
        'echasnovski/mini.operators',
        version = '*',
        event = 'VeryLazy',
        opts = {
            multiply = { prefix = 'gM' },
            sort = { prefix = 'gR' }, -- "[R]eorder".
        },
    },
    {
        'echasnovski/mini.surround',
        version = '*',
        event = 'VeryLazy',
        opts = {
            -- NOTE: `''` disables a mapping.
            mappings = {
                add = 'gSa',
                delete = 'gSd',
                replace = 'gSr',
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
        'echasnovski/mini.align',
        version = '*',
        event = 'VeryLazy',
        opts = {
            mappings = {
                start = '',
                start_with_preview = 'gA',
            },
        },
    },
    {
        'echasnovski/mini.pairs',
        version = '*',
        event = 'VeryLazy',
        opts = {},
    },
}
