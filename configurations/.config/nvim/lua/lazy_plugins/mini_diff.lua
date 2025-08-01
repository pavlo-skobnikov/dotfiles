return {
    'echasnovski/mini.diff',
    lazy = false,
    ---@class Gitsigns.config
    opts = {
        mappings = {
            apply = 'gh', -- Apply hunks inside a visual/operator region.
            reset = 'gH', -- Reset hunks inside a visual/operator region.

            textobject = '', -- Disabe textobject hunk apply.

            goto_first = '[C', -- Go to hunk range in corresponding direction.
            goto_prev = '[c',
            goto_next = ']c',
            goto_last = ']C',
        },
    },
}
