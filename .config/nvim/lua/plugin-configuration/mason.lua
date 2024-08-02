require('mason').setup { ui = { border = 'none', width = 1, height = 1 } }

local registry = require 'mason-registry'

-- Ensure certain packages are readily available.
vim
  .iter({
    -- Lua.
    'lua-language-server',
    'stylua',
    -- Bash.
    'bash-language-server',
    'shfmt',
    -- Toml.
    'taplo',
  })
  :filter(function(package_name) return not registry.is_installed(package_name) end)
  :each(function(package_name) registry.get_package(package_name):install() end)
