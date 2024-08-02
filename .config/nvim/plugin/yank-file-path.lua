vim.api.nvim_create_user_command('YankFilePath', function(opts)
  local file_path = './' .. vim.fn.expand '%:.'

  -- Check if command was called with a range (visual mode)
  if opts.range == 2 then file_path = file_path .. ':' .. opts.line1 .. ':' .. opts.line2 end

  vim.fn.setreg(opts.args, file_path)

  vim.notify('File path: ' .. file_path)
end, {
  nargs = 1,
  desc = "Yanks to given register and prints the currently focused file's path from the current working directory (supports line ranges in visual mode)",
  range = true,
})
