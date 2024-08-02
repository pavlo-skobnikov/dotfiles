require('catppuccin').setup {
  -- Options: latte, frappe, macchiato, mocha.
  flavour = 'auto',
  background = { light = 'latte', dark = 'frappe' },
  -- Manually define integrations.
  default_integrations = false,
  auto_integrations = false,
  integrations = {
    mini = { enabled = true },
    which_key = true,
  },
}

-- Apply the colorscheme.
vim.cmd.colorscheme 'catppuccin'

-- Set theme based on MacOS' current System Appearance setting.
if vim.fn.system 'defaults read -g AppleInterfaceStyle 2> /dev/null' == '' then
  vim.opt.background = 'light'
else
  vim.opt.background = 'dark'
end
