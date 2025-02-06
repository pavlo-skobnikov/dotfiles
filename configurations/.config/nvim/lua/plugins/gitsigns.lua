-- https://github.com/lewis6991/gitsigns.nvim
return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(modes, lhs, rhs, desc)
          vim.keymap.set(modes, lhs, rhs, { desc = desc })
        end

        -- Actions
        map('n', '<LEADER>gs', gitsigns.stage_hunk, 'Stage hunk')
        map('v', '<LEADER>gs', function()
          gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Stage hunk')
        map('n', '<LEADER>gS', gitsigns.stage_buffer, 'Stage buffer')

        map('n', '<LEADER>gr', gitsigns.reset_hunk, 'Reset hunk')
        map('v', '<LEADER>gr', function()
          gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'Reset hunk')
        map('n', '<LEADER>gR', gitsigns.reset_buffer, 'Reset buffer')

        map('n', '<LEADER>gh', gitsigns.preview_hunk, 'Preview hunk')
        map('n', '<LEADER>gH', gitsigns.preview_hunk_inline, 'Preview hunk inline')

        map('n', '<LEADER>gb', function()
          gitsigns.blame_line({ full = true })
        end, 'Blame line')

        map('n', '<LEADER>gd', gitsigns.diffthis, 'Diff against index')
        map('n', '<LEADER>gD', ':Gitsigns diffthis ', 'Specify diff against')

        map('n', '<LEADER>gQ', function() gitsigns.setqflist('all') end, 'Send project hunks to qflist')
        map('n', '<LEADER>gq', gitsigns.setqflist, 'Send buffer hunks to qflist')

        map('n', '<LEADER>gL', gitsigns.toggle_deleted, 'Toggle deleted lines')
        map('n', '<LEADER>gW', gitsigns.toggle_word_diff, 'Toggle word diff highlight')

        -- Text object.
        map({'o', 'x'}, 'ic', ':<C-U>Gitsigns select_hunk<CR>', 'inner change')

        -- Navigation.
        local function map_nav_hunk(lhs, direction, desc)
          map('n', lhs, function()
            if vim.wo.diff then
              vim.cmd.normal({lhs, bang = true})
            else
              gitsigns.nav_hunk(direction)
            end
          end, desc)
        end

        map_nav_hunk('[c', 'prev', 'Previous change')
        map_nav_hunk(']c', 'next', 'Next change')
      end
    }
  end,
}
