vim.api.nvim_create_user_command('SetLocalTabSpaces', function(opts)
  local spaces_count = tonumber(opts.args)

  vim.opt_local.shiftwidth = spaces_count
  vim.opt_local.tabstop = spaces_count
  vim.opt_local.listchars = {
    extends = '▸',
    precedes = '◂',
    trail = '·',
    tab = '>·',
    leadmultispace = '▏' .. string.rep(' ', spaces_count - 1),
  }
end, {
  nargs = 1,
  desc = 'Set shiftwidth, tabstop, and listchars leadmultispace dynamically',
})
