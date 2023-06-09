local dap_go = require 'dap-go'

local go_cmds = vim.api.nvim_create_augroup('go_cmds', { clear = true })

local function setup_dap_go()
  dap_go.setup()
end

local function set_dap_keymaps()
  vim.keymap.set('n', '<leader>dtn', dap_go.debug_test, { desc = 'Debug Nearest Test' })
  vim.keymap.set('n', '<leader>dtl', dap_go.debug_last_test, { desc = 'Debug Last Test' })
end

local function go_setup()
  setup_dap_go()
  set_dap_keymaps()
end

vim.api.nvim_create_autocmd('FileType', {
  group = go_cmds,
  pattern = { 'go' },
  desc = 'Setup Go',
  callback = go_setup,
})
