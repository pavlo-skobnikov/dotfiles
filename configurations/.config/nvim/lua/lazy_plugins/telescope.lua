return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
        },
    },
    lazy = false,
    keys = function()
        local builtin = require 'telescope.builtin'

        return {
            -- Files.
            { '<Leader>ff', builtin.find_files, desc = 'Find files' },
            { '<Leader>fb', builtin.buffers, desc = 'Search buffers' },
            { '<Leader>fr', builtin.oldfiles, desc = 'Search recent files' },
            { '<Leader>fg', builtin.live_grep, desc = 'Live grep' },
            -- Git.
            { '<Leader>gl', builtin.git_commits, desc = 'Search commit log' },
            { '<Leader>gh', builtin.git_bcommits, desc = 'Search buffer commit history' },
            { '<Leader>gc', builtin.git_branches, desc = 'Checkout branches' },
            { '<Leader>gH', builtin.git_stash, desc = 'View hidden changesets (stash)' },
            -- Built-in Neovim lists.
            { '<Leader>q', builtin.quickfix, desc = 'Search qflist' },
            { '<Leader>Q', builtin.quickfixhistory, desc = 'Search qflist history' },
            { '<Leader>l', builtin.loclist, desc = 'Search loclist' },
            { '<Leader>j', builtin.jumplist, desc = 'Search jumplist' },
            -- Miscellaneous.
            { '<Leader>b', builtin.marks, desc = 'Search marks' },
            { '<Leader>/', builtin.commands, desc = 'Search commands' },
            {
                '<Leader>?',
                builtin.command_history,
                desc = 'Search recently executed commands',
            },
            { '<Leader>:', builtin.help_tags, desc = 'Search help tags' },
            { "<Leader>'", builtin.resume, desc = 'Resume previous search' },
            {
                'g/',
                builtin.current_buffer_fuzzy_find,
                desc = 'Fuzzy search current buffer',
            },
        }
    end,
    opts = function()
        local actions = require 'telescope.actions'

        return {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = { width = 0.85, height = 0.85 },
                mappings = {
                    n = {
                        ['<C-f>'] = actions.preview_scrolling_right,
                        ['<C-b>'] = actions.preview_scrolling_left,
                    },
                    i = {
                        ['<C-f>'] = actions.preview_scrolling_right,
                        ['<C-b>'] = actions.preview_scrolling_left,
                    },
                },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--unrestricted',
                    '--hidden',
                    '--glob',
                    '!**/.git/*',
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        'rg',
                        '--files',
                        '--hidden',
                        '--ignore-vcs',
                        '--glob',
                        '!**/.git/*',
                    },
                },
                -- I have to admit, Emacs' Ivy does look kinda cool.
                current_buffer_fuzzy_find = {
                    theme = 'ivy',
                    layout_config = { height = 0.3 },
                },
            },
        }
    end,
    config = function(_, opts)
        local telescope = require 'telescope'

        telescope.setup(opts)

        -- Add Telescope-specific language-server maps.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('AddTelescopeLspMaps', { clear = true }),
            pattern = '*',
            callback = function()
                local builtin = require 'telescope.builtin'

                local function map(m, lhs, rhs, desc)
                    vim.keymap.set(m, lhs, rhs, { buffer = true, desc = desc })
                end

                map({ 'n', 'v' }, '<C-]>', builtin.lsp_definitions, 'Go to definition')
                map({ 'n', 'v' }, 'gy', builtin.lsp_type_definitions, 'Go to type definition')

                map('n', '<Leader>kw', builtin.lsp_workspace_symbols, 'Search project symbols')
                map('n', '<Leader>ks', builtin.lsp_document_symbols, 'Search document symbols')

                map({ 'n', 'v' }, '<Leader>ki', builtin.lsp_implementations, 'Go to implementation')
                map('n', '<Leader>kI', builtin.lsp_incoming_calls, 'Find incoming calls')
                map('n', '<Leader>kO', builtin.lsp_outgoing_calls, 'Find outgoing calls')
                map(
                    'n',
                    '<Leader>kd',
                    function() builtin.diagnostics { buffer = 0 } end,
                    'View document diagnostics'
                )
                map('n', '<Leader>ke', builtin.diagnostics, 'View project errors')
                map('n', '<Leader>kf', builtin.lsp_references, 'Find references')
            end,
            desc = 'Set buffer-local Telescope-based language-server mappings',
        })

        telescope.load_extension 'fzf'
    end,
}
