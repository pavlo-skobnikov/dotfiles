return {
    'github/copilot.vim',
    event = 'VeryLazy',
    config = function()
        vim.keymap.set('i', '<M-Right>', '<Plug>(copilot-accept-word)')
        vim.keymap.set('i', '<M-Left>', '<Plug>(copilot-accept-line)')

        vim.keymap.set('i', '<M-Up>', '<Plug>(copilot-previous)')
        vim.keymap.set('i', '<M-Down>', '<Plug>(copilot-next)')
    end,
}
