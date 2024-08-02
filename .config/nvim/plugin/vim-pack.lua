local function get_installed_plugin_names()
  return vim.iter(vim.pack.get()):map(function(plugin_info) return plugin_info.spec.name end):totable()
end

local installed_plugins_cache

local function installed_plugins_completion_function()
  if installed_plugins_cache == nil then installed_plugins_cache = get_installed_plugin_names() end

  return installed_plugins_cache
end

vim.api.nvim_create_autocmd('CmdlineEnter', {
  callback = function() installed_plugins_cache = nil end,
  desc = 'Reset installed plugins cache used by the Pack.* commands',
})

vim.api.nvim_create_user_command('PackUpdate', function(opts)
  if not opts.args == '' then
    vim.pack.update(opts.fargs)
  else
    vim.pack.update()
  end
end, {
  nargs = '*',
  complete = installed_plugins_completion_function,
  desc = 'Update given vim.pack plugins or all if none is provided',
})

vim.api.nvim_create_user_command('PackDelete', function(opts) vim.pack.del(opts.fargs) end, {
  nargs = '+',
  complete = installed_plugins_completion_function,
  desc = 'Delete given vim.pack plugins',
})
