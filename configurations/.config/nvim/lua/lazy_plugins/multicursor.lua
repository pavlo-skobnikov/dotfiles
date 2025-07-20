local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, {
        silent = true,
        desc = desc,
    })
end

return {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    event = 'VeryLazy',
    config = function()
        local mc = require 'multicursor-nvim'

        mc.setup()

        local function dir_fn(fn, dir)
            return function() fn(dir) end
        end

        map({ 'n', 'x' }, '<Up>', dir_fn(mc.lineAddCursor, -1), 'Add cursor above')
        map({ 'n', 'x' }, '<C-Up>', dir_fn(mc.lineSkipCursor, -1), 'Skip cursor above')
        map({ 'n', 'x' }, '<Down>', dir_fn(mc.lineAddCursor, 1), 'Add cursor below')
        map({ 'n', 'x' }, '<C-Down>', dir_fn(mc.lineSkipCursor, 1), 'Skip cursor below')

        map({ 'n', 'x' }, '<Right>', dir_fn(mc.matchAddCursor, 1), 'Add cursor to next match')
        map({ 'n', 'x' }, '<C-Right>', dir_fn(mc.matchSkipCursor, 1), 'Skip cursor to next match')
        map({ 'n', 'x' }, '<Left>', dir_fn(mc.matchAddCursor, -1), 'Add cursor to prev match')
        map({ 'n', 'x' }, '<C-Left>', dir_fn(mc.matchSkipCursor, -1), 'Skip cursor to prev match')

        map({ 'n', 'x' }, '<Leader>A', mc.matchAllAddCursors, 'Add cursors for all matches')

        map({ 'n', 'x' }, '<C-q>', mc.toggleCursor, 'Toggle cursor enabled')
        map({ 'n', 'x' }, '<Leader><C-q>', mc.duplicateCursors, 'Clone and disable originals')

        local function apply_to_buf_fn(fn)
            return function()
                vim.cmd 'normal! ggVG'
                fn()
            end
        end

        map('n', '<Leader>s', apply_to_buf_fn(mc.matchCursors), 'Select regex matches in buffer')
        map('x', '<Leader>s', mc.matchCursors, 'Select regex matches in selection')
        map('n', '<Leader>S', apply_to_buf_fn(mc.splitCursors), 'Split by regex in buffer')
        map('x', '<Leader>S', mc.splitCursors, 'Split by regex in selection')

        map({ 'n', 'x' }, '<Leader>m', mc.operator, 'Add cursor per text object in text object')
        map('x', '<Leader>M', mc.addCursorOperator, 'Add cursor per line in text object')

        map('x', '<Leader>;', dir_fn(mc.transposeCursors, 1), 'Rotate selections right')
        map('x', '<Leader>,', dir_fn(mc.transposeCursors, -1), 'Rotate selections left')

        map('x', 'I', mc.insertVisual, 'Insert before each line')
        map('x', 'A', mc.appendVisual, 'Append after each line')

        map({ 'n', 'x' }, 'gA', mc.alignCursors, 'Align cursors')

        map({ 'n', 'x' }, '<Leader><C-a>', mc.sequenceIncrement, 'Increment multicursor sequence')
        map({ 'n', 'x' }, '<Leader><C-x>', mc.sequenceDecrement, 'Decrement multicursor sequence')

        -- Mappings for only when multiple cursors are active.
        mc.addKeymapLayer(function(layerSet)
            layerSet({ 'n', 'x' }, 'H', mc.prevCursor, { desc = 'Select previous cursor' })
            layerSet({ 'n', 'x' }, 'L', mc.nextCursor, { desc = 'Select next cursor' })

            layerSet({ 'n', 'x' }, 'M', mc.deleteCursor, { desc = 'Remove current cursor' })

            layerSet('n', '<Esc>', function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end, { desc = 'Clear cursors or enable them' })
        end)

        vim.api.nvim_set_hl(0, 'MultiCursorCursor', { reverse = true })
        vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
        vim.api.nvim_set_hl(0, 'MultiCursorSign', { link = 'SignColumn' })
        vim.api.nvim_set_hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
        vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { reverse = true })
        vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
        vim.api.nvim_set_hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
}
