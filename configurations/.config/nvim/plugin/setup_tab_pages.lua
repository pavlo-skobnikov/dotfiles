-- Set custom tab line of the following form:
--  [{TAB_NUMBER}] #{COUNT_OF_BUFFERS_IN_TAB} > {FOCUSED_BUFFER_FILE_NAME_IN_TAB}

---@param tab_nr integer
local function get_tab_last_focused_file_name(tab_nr)
    local tab_buffers = vim.fn.tabpagebuflist(tab_nr)
    local focused_win_nr = vim.fn.tabpagewinnr(tab_nr)

    local fname = vim.fn.expand('#' .. tab_buffers[focused_win_nr] .. ':t')

    if not fname or fname == '' then
        -- If the file name is empty, return a placeholder.
        return '[No name]'
    else
        -- Otherwise, return the file name.
        return fname
    end
end

function _G.MyGlobals.Tabline()
    local tabline_opt = ''
    local tab_count = vim.fn.tabpagenr '$'

    for i = 1, tab_count do
        -- Add highlighting for tab page lines.
        if i == vim.fn.tabpagenr() then
            -- Highlighting for the currently selected tab's line.
            tabline_opt = tabline_opt .. '%#TabLineSel#'
        else
            tabline_opt = tabline_opt .. '%#TabLine#'
        end

        -- Create a new tab line.
        tabline_opt = tabline_opt .. '%' .. i .. 'T'

        -- Create the label from...
        --  ... tab's number.
        tabline_opt = tabline_opt .. ' [' .. i .. ']'
        --  ... amount of opened buffers in the tab.
        tabline_opt = tabline_opt .. ' #' .. #vim.fn.tabpagebuflist(i)
        --  ... currently focused buffer's file name in the tab.
        tabline_opt = tabline_opt .. ' > ' .. get_tab_last_focused_file_name(i) .. ' '
    end

    -- Fill out the rest of the space with other highlighting.
    tabline_opt = tabline_opt .. '%#TabLineFill#%T'

    return tabline_opt
end

vim.o.tabline = '%!v:lua.MyGlobals.Tabline()'

-- Maps.
vim.keymap.set('n', 'go', '<Cmd>tabnew %<Cr>', { desc = 'Open a new tab' })

vim.keymap.set({ 'n', 'x' }, 'g<Tab>', '<Cmd>tablast<Cr>', { desc = 'Go to the last opened tab' })

vim.keymap.set({ 'n', 'x' }, 'gC', function()
    if vim.v.count == 0 then
        return '<Cmd>tabclose<Cr>'
    else
        return '<Cmd>' .. vim.v.count .. 'tabclose<Cr>'
    end
end, { desc = 'Close [count] tab', expr = true })
vim.keymap.set({ 'n', 'x' }, 'gO', '<Cmd>tabonly<Cr>', { desc = 'Close all other tabs' })

vim.keymap.set({ 'n', 'x' }, 'gH', '<Cmd>-tabmove<Cr>', { desc = 'Go to the left tab' })
vim.keymap.set({ 'n', 'x' }, 'gL', '<Cmd>+tabmove<Cr>', { desc = 'Go to the right tab' })
