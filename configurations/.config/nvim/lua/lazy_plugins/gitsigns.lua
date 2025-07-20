return {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    ---@class Gitsigns.config
    opts = {
        -- Use number column to show VCS information to preserve space.
        signcolumn = false,
        numhl = true,
        -- Only add maps on git-tracked buffers.
        on_attach = function(bufnr)
            local gitsigns = require 'gitsigns'

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
            end
            local function map_nav(l, dir, desc)
                map('n', l, function()
                    if vim.wo.diff then
                        vim.cmd.normal { l, bang = true }
                    else
                        gitsigns.nav_hunk(dir)
                    end
                end, desc)
            end

            -- Navigation.
            map_nav(']c', 'next', 'Next hunk')
            map_nav('[c', 'prev', 'Previous hunk')

            -- Actions.
            map('n', '<Leader>gs', gitsigns.stage_hunk, 'Stage hunk')
            map(
                'v',
                '<Leader>gs',
                function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
                'Stage selected hunk'
            )
            map('n', '<Leader>gS', gitsigns.stage_buffer, 'Stage buffer')

            map('n', '<Leader>gr', gitsigns.reset_hunk, 'Reset hunk')
            map(
                'v',
                '<Leader>gr',
                function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
                'Reset selected hunk'
            )
            map('n', '<Leader>gR', gitsigns.reset_buffer, 'Reset buffer')

            map('n', '<Leader>gp', gitsigns.preview_hunk, 'Preview hunk')

            map('n', '<Leader>gb', function() gitsigns.blame_line { full = true } end, 'Blame line')

            map('n', '<Leader>gd', gitsigns.diffthis, 'Diff against last commit')
            map(
                'n',
                '<Leader>gD',
                function() gitsigns.diffthis '~' end,
                'Diff against the parent of the last commit'
            )

            map('n', '<Leader>gq', gitsigns.setqflist, 'Add buffer changes to qflist')
            map(
                'n',
                '<Leader>gQ',
                ---@diagnostic disable-next-line: param-type-mismatch
                function() gitsigns.setqflist 'all' end,
                'Add project changes to qflist'
            )

            -- Toggles.
            map('n', '<Leader>gtb', gitsigns.toggle_current_line_blame, 'Toggle current line blame')
            map('n', '<Leader>gtw', gitsigns.toggle_word_diff, 'Toggle word diff')

            -- Text object.
            map({ 'o', 'x' }, 'ic', gitsigns.select_hunk, 'inside change')
        end,
    },
}
