local treesitter = require 'nvim-treesitter'

-- Always ensure the following language parsers are installed.
treesitter.install {
  'lua',
  'python',
  'rust',
  'java',
  'kotlin',
  'scala',
  'clojure',
  'dockerfile',
  'bash',
  'zsh',
  'sql',
  'json',
  'xml',
  'yaml',
  'toml',
  'tmux',
  'markdown',
  'markdown_inline',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
}

-- Automatically update Treesitter parsers when updating vim.pack plugins.
vim.api.nvim_create_autocmd('PackChanged', {
  pattern = 'nvim-treesitter',
  callback = function() vim.cmd [[ TSUpdate ]] end,
  desc = 'Update installed Treesitter parsers on vim.pack plugin update',
})

-- Set up Treesitter for syntaxt highlighting in buffers.
vim.api.nvim_create_user_command('TSStartAndSetOptions', function()
  -- Start Treesitter for the current buffer.
  vim.treesitter.start()

  -- Configure Treesitter-based folding and indentation.
  vim.wo.foldmethod = 'expr'
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

  -- Only fold by default *really deeply* nested code.
  vim.opt.foldlevel = 20
end, { desc = 'Starts Treesitter highlighting for the buffer and sets relevant options' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = treesitter.get_available(),
  callback = function()
    local filetype = vim.bo.filetype

    -- Start Treesitter for the buffer or notify about parser availability.
    if vim.tbl_contains(treesitter.get_installed(), filetype) then
      vim.cmd [[ TSStartAndSetOptions ]]
    else
      vim.notify("No Treesitter parser installed for current filetype although it's available", vim.log.levels.WARN)
    end
  end,
  desc = 'Enable Treesitter-based highlighting, folding, and indentation for supported filetypes',
})

require('nvim-treesitter-textobjects').setup {
  select = {
    -- Automatically jump forward to the text object.
    lookahead = true,
    -- How by default textobjects are selected:
    selection_modes = {
      -- => charwise
      ['@parameter.outer'] = 'v',
      -- => linewise
      ['@function.outer'] = 'V',
      -- => blockwise
      ---@diagnostic disable-next-line: assign-type-mismatch
      ['@class.outer'] = '<C-v>',
    },
    include_surrounding_whitespace = true,
  },
  -- Add jump locations in the jumplist.
  move = { set_jumps = true },
}
