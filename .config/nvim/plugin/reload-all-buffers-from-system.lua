vim.api.nvim_create_user_command('ReloadAllBuffersFromSystem', function() vim.cmd [[ bufdo e! ]] end, {
  desc = 'Refresh and reload all buffers from system state',
})
