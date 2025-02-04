-- Custom native status lines for active and inactive windows.

-- Get the current git branch name as a component of the status line.
local function get_git_branch_component()
  local result = vim.fn.system('git branch --show-current')

  if string.match(result, 'fatal') then return '' end

  return '(' .. vim.fn.trim(result) .. ')'
end

-- Active window statusline autocommand.
vim.api.nvim_create_autocmd({'WinEnter', 'BufEnter'}, {
  group = vim.api.nvim_create_augroup('UpdateStatusLineForActiveWindow', { clear = true }),
  pattern = { '*' },
  callback = function()
    vim.opt_local.statusline = '%f  %r%m%=' .. '%y' .. '  ' .. get_git_branch_component() .. '  ' .. '%l,%c    %P'
  end,
  desc = 'Update the active window status line',
})

-- Inactive window statusline autocommand.
vim.api.nvim_create_autocmd({'WinLeave', 'BufLeave'}, {
  group = vim.api.nvim_create_augroup('UpdateStatusLineForInactiveWindow', { clear = true }),
  pattern = { '*' },
  callback = function()
    vim.opt_local.statusline = '[%{winnr()}] - %t  %r%m'
  end,
  desc = 'Update the inactive window status line',
})
