return {
    'echasnovski/mini.pick',
    dependencies = 'echasnovski/mini.icons',
    event = 'VeryLazy',
    keys = function()
        return {
            -- Files & file contents.
            {
                '<Leader>.',
                function()
                    MiniPick.builtin.cli({
                        command = { 'rg', '--files', '--no-follow', '--color=never', '--hidden', '--glob=!.git/*' },
                    }, {
                        source = { name = 'Files incl. hidden (rg)' },
                        show = MiniPick.default_show,
                    })
                end,
                desc = 'Find files incl. hidden',
            },
            { '<Leader>,', '<Cmd>Pick buffers<Cr>', desc = 'Search buffers' },
            { '<Leader>/', '<Cmd>Pick grep_live<Cr>', desc = 'Grep files' },
            { 'g/', '<Cmd>Pick buf_lines<Cr>', desc = 'Fuzzy search buffer contents' },
            -- Diagnostics.
            { '<Leader>d', "<Cmd>Pick diagnostic scope='current'<Cr>", desc = 'View buffer diagnostics' },
            { '<Leader>D', "<Cmd>Pick diagnostic scope='all'<Cr>", desc = 'View project diagnostics' },
            -- Git.
            { '<Leader>gc', '<Cmd>Pick git_branches<Cr>', desc = 'Checkout branches' },
            { '<Leader>gr', '<Cmd>Pick git_commits<Cr>', desc = 'Open repository commit log' },
            { '<Leader>gf', "<Cmd>Pick git_commits path='%'<Cr>", desc = 'Open file commit log' },
            { '<Leader>gd', "<Cmd>Pick git_commits path='expand('%:h')'<Cr>", desc = 'Open directory commit log' },
            { '<Leader>gs', "<Cmd>Pick git_hunks scope='staged'<Cr>", desc = 'Search staged hunks' },
            { '<Leader>gu', "<Cmd>Pick git_hunks scope='unstaged'<Cr>", desc = 'Search unstaged hunks' },
            -- Neovim built-in lists.
            { '<Leader>qf', "<Cmd>Pick list scope='quickfix'<Cr>", desc = 'Search qflist entries' },
            { '<Leader>lf', "<Cmd>Pick list scope='location'<Cr>", desc = 'Search loclist entries' },
            { '<Leader>J', "<Cmd>Pick list scope='jump'<Cr>", desc = 'Open previous jump locations' },
            { '<Leader>L', "<Cmd>Pick list scope='change'<Cr>", desc = 'Open previous change locations' },
            { '<Leader>m', "<Cmd>Pick marks scope='global'<Cr>", desc = 'View global marks' },
            { '<Leader>M', "<Cmd>Pick marks scope='buf'<Cr>", desc = 'View buffer marks' },
            -- Miscellaneous.
            { '<C-x>s', '<Cmd>Pick spellsuggest<Cr>', mode = 'i', desc = 'Select and apply a spellsuggest' },
            { '<Leader>?', '<Cmd>Pick commands<Cr>', desc = 'Search and run commands' },
            { '<Leader>:', '<Cmd>Pick help<Cr>', desc = 'Search help tags' },
            { "<Leader>'", '<Cmd>Pick resume<Cr>', desc = 'Resume previous search' },
            { '<Leader>"', '<Cmd>Pick registers<Cr>', desc = 'Search registers' },
            { '<Leader>\\', "<Cmd>Pick history scope='/'<Cr>", desc = "Search '/' history" },
        }
    end,
    opts = {
        mappings = {
            scroll_up = '<C-u>',
            scroll_down = '<C-d>',
            scroll_left = '<C-b>',
            scroll_right = '<C-f>',
        },
    },
    config = function(_, opts)
        local pick = require 'mini.pick'

        pick.setup(opts)

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('AddMiniPickLspMaps', { clear = true }),
            pattern = '*',
            callback = function()
                local function map(m, lhs, rhs, desc) vim.keymap.set(m, lhs, rhs, { buffer = true, desc = desc }) end

                map({ 'n', 'x' }, '<C-]>', "<Cmd>Pick lsp scope='definition'<Cr>", 'Go to definition')
                map({ 'n', 'x' }, 'gD', "<Cmd>Pick lsp scope='declaration'<Cr>", 'Go to declaration')
                map({ 'n', 'x' }, 'gd', "<Cmd>Pick lsp scope='type_definition'<Cr>", 'Go to type definition')
                map({ 'n', 'x' }, '<Leader>i', "<Cmd>Pick lsp scope='implementation'<Cr>", 'Go to implementation')
                map({ 'n', 'x' }, '<Leader>s', "<Cmd>Pick lsp scope='document_symbol'<Cr>", 'Search document symbols')
                map({ 'n', 'x' }, '<Leader>S', "<Cmd>Pick lsp scope='workspace_symbol'<Cr>", 'Search workspace symbol')
                map({ 'n', 'x' }, '<Leader>R', "<Cmd>Pick lsp scope='references'<Cr>", 'Find references')
            end,
            desc = 'Set buffer-local MiniPick-based language-server-related mappings',
        })

        -- Use `MiniPick` as a replacement for `vim.ui.select`.
        vim.ui.select = pick.ui_select
    end,
}
