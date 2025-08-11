-- [[ Scrolling ]]
vim.keymap.set({ 'n', 'x' }, '<C-d>', '<C-d>zz', { desc = 'Half-page down and center' })
vim.keymap.set({ 'n', 'x' }, '<C-u>', '<C-u>zz', { desc = 'Half-page up and center' })
vim.keymap.set({ 'n', 'x' }, '<C-f>', 'zL', { desc = 'Half-screen to the right' })
vim.keymap.set({ 'n', 'x' }, '<C-b>', 'zH', { desc = 'Half-screen to the left' })

-- [[ Windows ]]
vim.keymap.set({ 'n', 'x' }, '<C-w><Tab>', '<C-w>p', { desc = 'Go to the last-focused window' })

vim.keymap.set({ 'n', 'x' }, '<C-w>-', ':resize -5<Cr>', { desc = 'Decrease window height by 5' })
vim.keymap.set({ 'n', 'x' }, '<C-w>+', ':resize +5<Cr>', { desc = 'Increase window width by 5' })
vim.keymap.set({ 'n', 'x' }, '<C-w><', ':vertical resize -5<Cr>', { desc = 'Decrease window width by 5' })
vim.keymap.set({ 'n', 'x' }, '<C-w>>', ':vertical resize +5<Cr>', { desc = 'Increase window width by 5' })

-- [[ Quick actions ]]
vim.keymap.set('n', 'R', ':%s/', { desc = ':s on buffer' })
vim.keymap.set('x', 'R', ':s/', { desc = ':s on selection' })

vim.keymap.set('n', 'ga', ':%normal ', { desc = ':normal on buffer' })
vim.keymap.set('x', 'ga', ':normal ', { desc = ':normal on selection' })

-- [[ Register shenanigans ]]
vim.keymap.set({ 'n', 'x' }, 'gy', '"+', { desc = 'Use system register' })
vim.keymap.set({ 'n', 'x' }, 'gY', '"_', { desc = 'Use blackhole register' })

-- [[ Files ]]
vim.keymap.set('n', '<Leader>fy', function()
    local file_path = vim.fn.expand '%:p'

    vim.fn.setreg('+', file_path)

    print('Current file path: ' .. file_path)
end, { desc = 'Yank @+ and print file path' })

vim.keymap.set('n', '<Leader>fr', '<Cmd>edit<Cr>', { desc = 'Reload file from disk' })

-- Go to next/previous/first/last file in current directory without Netrw.

---Utility function to get `ls` results for the given directory as a table
---of strings.
local function ls(dir)
    local ls_out = vim.system({ 'ls', dir }, { text = true }):wait().stdout

    if not ls_out then return end

    return vim.split(ls_out, '\n', { trimempty = true })
end

---@param target 'first' | 'last' | 'prev' | 'next' Which file to focus.
local function focus(target)
    local curr_dir = vim.fn.expand '%:p:h'
    local function edit(fname) vim.cmd('edit ' .. curr_dir .. '/' .. fname) end

    local fnames = ls(curr_dir)
    if not fnames then
        vim.notify('Directory has no files', vim.log.levels.ERROR)
        return
    end

    if target == 'first' then
        edit(fnames[1])
    elseif target == 'last' then
        edit(fnames[#fnames])
    else
        local curr_fname = vim.fn.expand '%:t'

        local curr_fname_idx
        for i, file in ipairs(fnames) do
            if curr_fname == file then
                curr_fname_idx = i
                break
            end
        end

        if target == 'prev' then
            edit(fnames[math.max(1, curr_fname_idx - 1)])
        else
            edit(fnames[math.min(#fnames, curr_fname_idx + 1)])
        end
    end
end

vim.keymap.set('n', '<Leader>ff', function() focus 'first' end, { desc = 'Jump to the first dir file' })
vim.keymap.set('n', '<Leader>fp', function() focus 'prev' end, { desc = 'Jump to the previous dir file' })
vim.keymap.set('n', '<Leader>fl', function() focus 'last' end, { desc = 'Jump to the last dir file' })
vim.keymap.set('n', '<Leader>fn', function() focus 'next' end, { desc = 'Jump to the next dir file' })
