-- https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  ---@class wk.Opts
  keys = {
  },
  config = function()
    local which_key = require('which-key')

    which_key.setup({
      preset = 'helix',
      delay = 50,
      win = {
        -- { Vertical, Horizontal }
        padding = { 1, 2 },
        no_overlap = false,
        border = "none",
      },
      icons = { mappings = false },
    })

    which_key.add({
      -- Which-key maps.
      { '<LEADER>ib', function() which_key.show({ global = false }) end, desc = 'Show buffer-local keymaps', },
      -- Descriptions for common maps.
      { '[<SPACE>', mode = { 'n', 'v' }, desc = 'Add newline above' },
      { ']<SPACE>', mode = { 'n', 'v' }, desc = 'Add newline below' },
      { 'gs', mode = { 'n', 'v' }, desc = 'Use system clipboard register' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Use blackhole register' },
      -- Group descriptions.
      { '<LEADER>g', group = 'Git...' },
      { '<LEADER>i', group = 'IDE...' },
    })
end,
}
