return {
    'olimorris/codecompanion.nvim',
    event = 'VeryLazy',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        { 'echasnovski/mini.diff', opts = {} },
        {
            'ravitemer/mcphub.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim',
            },
            build = 'npm install -g mcp-hub@latest & update-nvm-current-symlink.sh',
            opts = {
                ui = {
                    width = 0.85,
                    height = 0.85,
                },
            },
        },
    },
    opts = {
        strategies = {
            chat = { adapter = 'copilot' },
            inline = { adapter = 'copilot' },
            cmd = { adapter = 'copilot' },
        },
        extensions = {
            mcphub = {
                callback = 'mcphub.extensions.codecompanion',
                opts = {
                    make_vars = true,
                    make_slash_commands = true,
                    show_result_in_chat = true,
                },
            },
        },
    },
    keys = {
        {
            '<Leader>c',
            '<Cmd>CodeCompanionChat<Cr>',
            mode = { 'n', 'x' },
            desc = 'Focus code companion chat',
        },
        {
            '<Leader>C',
            '<Cmd>CodeCompanion<Cr>',
            mode = { 'n', 'x' },
            desc = 'Use code companion inline assistant',
        },
    },
}
