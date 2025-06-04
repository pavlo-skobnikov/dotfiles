local g = vim.g
local o = vim.opt

-- Set leader keys.
g.mapleader = ' '
g.maplocalleader = '\\'

-- General terminal/file options.
o.termguicolors = true
o.fileencoding = 'utf-8'

-- Visual markers for column widths and current line.
o.colorcolumn = '80,100,120'
o.cursorline = true

-- Enable relative line numbers.
o.number = true
o.relativenumber = true

-- Minimum number of rows/columns to keep visible when scrolling.
o.scrolloff = 10
o.sidescrolloff = 5

-- Enable displaying hidden characters.
o.list = true
o.listchars = {
    tab = '>·',
    leadmultispace = '▏   ',
    extends = '▸',
    precedes = '◂',
    trail = '·',
}

-- Treesitter-based folding w/o any folding when entering the buffer.
o.foldenable = true
o.foldlevel = 99
o.foldmethod = 'expr'
o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Use visual bell instead of beeping.
o.visualbell = true

-- Shorten some lines and bytes information in the cmdline.
o.shortmess = 'lF'

-- Never timeout when waiting for the next key of a keymap.
o.timeout = false
o.ttimeoutlen = 0

-- More modern completion.
o.completeopt = 'menu,menuone,preview,noinsert,fuzzy'

-- When set case is ignored when completing file names and directories.
o.wildignorecase = true

-- Case-insensitive searching unless upper case letters are present in the search term.
o.ignorecase = true
o.smartcase = true

-- Don't soft-wrap lines.
o.wrap = false

-- Only j/k can move the cursor to the next/previous line.
o.whichwrap = ''

-- Don't split words on wrapping by default.
o.linebreak = true

-- Indent soft wrapped lines to match the first line's indent
o.breakindent = true

-- Perform autoindenting when writing text.
o.smartindent = true

-- Use 4-space tabs by default.
o.expandtab = true
o.shiftround = true
o.shiftwidth = 4
o.tabstop = 4

-- Don't create a swap or backup files.
o.swapfile = false
o.writebackup = false

-- Enable persistent undo.
o.undofile = true
o.undolevels = 10000

-- Split below/to the right.
o.splitbelow = true
o.splitright = true
