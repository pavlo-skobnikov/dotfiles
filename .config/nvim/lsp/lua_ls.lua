---@class vim.lsp.Config
return {
  on_init = function(client)
    -- Custom configurations only when working on Neovim configuration.
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        (not string.match(path, '.config/nvim'))
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- LuaJIT version of Lua for Neovim.
        version = 'LuaJIT',
        -- Discover Lua modules same way as Neovim.
        -- `:h lua-module-load`
        path = { 'lua/?.lua', 'lua/?/init.lua' },
      },
      -- Make the server aware of Neovim runtime files:
      --    - Neovim core;
      --    - lazy.nvim-managed plugins;
      --    - my personal configuration.
      workspace = {
        checkThirdParty = false,
        library = vim.tbl_filter(
          function(d) return not d:match(vim.fn.stdpath 'config' .. '/?a?f?t?e?r?') end,
          vim.api.nvim_get_runtime_file('', true)
        ),
      },
    })
  end,
  settings = { Lua = {} },
}
