-- https://github.com/ellisonleao/gruvbox.nvim
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      -- Options: latte, frappe, macchiato, mocha.
      background = {
        light = "latte",
        dark = "frappe",
      },
      -- Manually manage integrations.
      default_integrations = false,
      -- https://github.com/catppuccin/nvim#integrations
      integrations = {
      },
    })

    -- Load the colorscheme.
    vim.cmd.colorscheme "catppuccin"
  end,
}
