-- This file sets all Neovim options according to my preferences.

-- Define options.
local options = {
  -- General terminal/file options.
  fileencoding = 'utf-8',
  termguicolors = true,

  -- Modern completion menu.
  completeopt = "menu,menuone,popup",
  -- Shorten some lines and bytes information in the cmdline.
  shortmess = 'lF',
  -- When set case is ignored when completing file names and directories.
  wildignorecase = true,

  -- Don't create a backup, swap, or backup files.
  backup = false,
  swapfile = false,
  writebackup = false,

  -- Enable persistent undo by saving the undo history to a file.
  undofile = true,
  undolevels = 10000,

  -- Split below and to the right of the current window.
  splitbelow = true,
  splitright = true,

  -- Use 2-space tabs.
  expandtab = true,
  shiftround = true,
  shiftwidth = 2,
  tabstop = 2,

  -- Perform autoindenting when writing text.
  smartindent = true,

  -- Always show sign column.
  signcolumn = "yes",

  -- Don't split words on wrapping by default.
  linebreak = true,

  -- Enable displaying hidden characters.
  list = true,
  listchars = {
    tab = '>·',
    leadmultispace = '▏ ',
    extends = '▸',
    precedes = '◂',
    trail = '·',
  },

  -- Treesitter-based folding.
  foldenable = true,
  foldlevel = 99,
  foldmethod = "expr",
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
}

-- Iterate over the table
for option, value in pairs(options) do
  local success, result = pcall(function () vim.opt[option] = value end)

  if not success then
    print("Setting `" .. option .. "` to value `" .. vim.inspect(value) .. "` failed")
    err(result)
  end
end

