-- https://github.com/tpope/vim-fugitive
return {
  'tpope/vim-fugitive',
  keys = {
    { '<LEADER>gg', '<CMD>Git<CR>', desc = 'Stage & commit' },
    { '<LEADER>gl', '<CMD>Git log<CR>', desc = 'Log' },
    { '<LEADER>gB', '<CMD>Git blame<CR>', desc = 'Toggle blame' },
    { '<LEADER>gf', '<CMD>Git fetch<CR>', desc = 'Fetch' },
    { '<LEADER>gp', '<CMD>Git pull<CR>', desc = 'Pull' },
    { '<LEADER>gP', '<CMD>Git push<CR>', desc = 'Push' },
  },
}
