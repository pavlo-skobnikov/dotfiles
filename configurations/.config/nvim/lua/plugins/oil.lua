-- https://github.com/stevearc/oil.nvim
return {
  'stevearc/oil.nvim',
  lazy = false,
  keys = {
    { '-', '<CMD>Oil<CR>', 'Open parent directory' },
    { '_', '<CMD>Oil ./<CR>', 'Open CWD' },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Make horizontal splits more similar to Neovim window maps.
    keymaps = {
      ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
      ["<C-h>"] = false,
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    },
    -- Show files and directories that start with "."
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
