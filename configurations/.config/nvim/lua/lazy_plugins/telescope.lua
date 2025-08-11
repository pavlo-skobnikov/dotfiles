return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'echasnovski/mini.icons',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5'
                .. ' && cmake --build build --config Release',
        },
        'nvim-telescope/telescope-ui-select.nvim',
    },
    event = 'VeryLazy',
    keys = function()
        local bi = require 'telescope.builtin'

        return {
            -- Files.
            { '<Leader>.', bi.find_files, mode = { 'n', 'v' }, desc = 'Find all files' },
            { '<Leader>,', bi.buffers, mode = { 'n', 'v' }, desc = 'Search buffers' },
            { '<Leader>/', bi.live_grep, mode = { 'n', 'v' }, desc = 'Live grep' },
            {
                'g/',
                bi.current_buffer_fuzzy_find,
                mode = { 'n', 'v' },
                desc = 'Fuzzy search buffer',
            },
            -- Git.
            { '<Leader>gc', bi.git_branches, mode = { 'n', 'v' }, desc = 'Checkout branches' },
            { '<Leader>gr', bi.git_commits, mode = { 'n', 'v' }, desc = 'Open repo. commits' },
            { '<Leader>gf', bi.git_bcommits, mode = 'n', desc = 'Open file commits' },
            { '<Leader>gf', bi.git_bcommits_range, mode = 'v', desc = 'Open range commits' },
            { '<Leader>gs', bi.git_status, mode = { 'n', 'v' }, desc = 'View status' },
            { '<Leader>gS', bi.git_stash, mode = { 'n', 'v' }, desc = 'View stash' },
            -- Diagnostics.
            {
                '<Leader>d',
                function() bi.diagnostics { buffer = 0 } end,
                mode = { 'n', 'v' },
                desc = 'View document diagnostics',
            },
            { '<Leader>D', bi.diagnostics, mode = { 'n', 'v' }, desc = 'View project diagnostics' },
            -- Built-in Neovim lists.
            { '<Leader>q', bi.quickfix, mode = { 'n', 'v' }, desc = 'Search qflist' },
            { '<Leader>Q', bi.quickfixhistory, mode = { 'n', 'v' }, desc = 'Search qflist history' },
            { '<Leader>l', bi.loclist, mode = { 'n', 'v' }, desc = 'Search loclist' },
            { '<Leader>j', bi.jumplist, mode = { 'n', 'v' }, desc = 'Search jumplist' },
            { '<Leader>m', bi.marks, mode = { 'n', 'v' }, desc = 'Search marks' },
            -- Miscellaneous.
            { '<C-x>s', bi.spell_suggest, mode = 'i', desc = 'Select and apply a spellsuggest' },
            { '<Leader>P', bi.pickers, mode = { 'n', 'v' }, desc = 'Run previous searches' },
            { '<Leader>?', bi.commands, mode = { 'n', 'v' }, desc = 'Search commands' },
            {
                '<Leader>\\',
                bi.command_history,
                mode = { 'n', 'v' },
                desc = 'Search recently executed commands',
            },
            { '<Leader>:', bi.help_tags, mode = { 'n', 'v' }, desc = 'Search help tags' },
            { "<Leader>'", bi.resume, mode = { 'n', 'v' }, desc = 'Resume previous search' },
            { '<Leader>"', bi.registers, mode = { 'n', 'v' }, desc = 'Search registers' },
        }
    end,
    opts = function()
        local actions = require 'telescope.actions'

        return {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = { width = 0.85, height = 0.85 },
                path_display = { truncate = 3 },
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                mappings = {
                    n = {
                        ['<C-x>'] = false,
                        ['<C-s>'] = actions.file_split,
                        ['<C-f>'] = actions.preview_scrolling_right,
                        ['<C-b>'] = actions.preview_scrolling_left,
                    },
                    i = {
                        ['<C-x>'] = false,
                        ['<C-s>'] = actions.file_split,
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
                    '--glob',
                    '!**/.idea/*',
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
                        '--glob',
                        '!**/.idea/*',
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
        local tele = require 'telescope'

        tele.setup(opts)

        -- Add Telescope-specific language-server maps.
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('AddTelescopeLanguageServerMaps', { clear = true }),
            pattern = '*',
            callback = function()
                local bi = require 'telescope.builtin'

                local function map(m, lhs, rhs, desc) vim.keymap.set(m, lhs, rhs, { buffer = true, desc = desc }) end

                map({ 'n', 'v' }, 'gd', bi.lsp_definitions, 'Go to definition')
                map({ 'n', 'v' }, 'gD', bi.lsp_type_definitions, 'Go to type definition')
                map({ 'n', 'v' }, '<Leader>i', bi.lsp_implementations, 'Go to implementation')

                map({ 'n', 'v' }, '<Leader>s', bi.lsp_document_symbols, 'Search document symbols')
                map({ 'n', 'v' }, '<Leader>S', bi.lsp_workspace_symbols, 'Search project symbols')

                map({ 'n', 'v' }, '<Leader>I', bi.lsp_incoming_calls, 'Find incoming calls')
                map({ 'n', 'v' }, '<Leader>O', bi.lsp_outgoing_calls, 'Find outgoing calls')
                map({ 'n', 'v' }, '<Leader>R', bi.lsp_references, 'Find references')
            end,
            desc = 'Set buffer-local Telescope-based language-server mappings',
        })

        tele.load_extension 'fzf'
        tele.load_extension 'ui-select'
    end,
}
