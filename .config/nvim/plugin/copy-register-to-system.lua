vim.api.nvim_create_user_command('CopyRegisterToSystem', function(opts)
  local register = opts.args
  local register_contents = vim.fn.getreg(register)

  if register_contents == '' then
    vim.notify('The register `' .. register .. '` is empty', vim.log.levels.WARN)

    return
  end

  vim.fn.setreg('+', register_contents)
end, {
  nargs = 1,
  desc = "Copy the provided register's contents to the system clipboard register",
})
