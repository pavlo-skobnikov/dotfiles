-- NOTE: `''` disables a mapping.
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
        'echasnovski/mini.pairs',
        version = '*',
        event = 'VeryLazy',
        opts = {},
    },
}
