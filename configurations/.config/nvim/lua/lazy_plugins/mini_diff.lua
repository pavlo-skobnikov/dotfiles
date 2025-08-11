return {
    'echasnovski/mini.diff',
    event = 'VeryLazy',
    keys = {
        ---@diagnostic disable-next-line: missing-parameter
        { '<Leader>gt', function() MiniDiff.toggle_overlay() end, mode = { 'n', 'v' }, desc = 'Toggle diff overlay' },
    },
    ---@class Gitsigns.config
    opts = {
        mappings = {
            goto_first = '[C',
            goto_prev = '[c',
            goto_next = ']c',
            goto_last = ']C',
        },
    },
}
