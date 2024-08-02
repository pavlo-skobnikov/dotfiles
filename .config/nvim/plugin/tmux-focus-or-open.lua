vim.api.nvim_create_user_command(
  'TmuxFocusOrOpen',
  function(opts) vim.system { 'tmux-window-switcher.sh', opts.args } end,
  {
    nargs = 1,
    complete = 'shellcmd',
    desc = 'Focus an existing Tmux window with the provided CLI tool or open a new one',
  }
)
