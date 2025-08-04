-- Leader keys.
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Never timeout when waiting for keymaps.
vim.opt.timeout = false

-- Quickly exit INSERT mode with Escape/C-[.
vim.opt.ttimeoutlen = 0

-- Use visual bell instead of beeping.
vim.opt.visualbell = true

-- Use square borders for pop-up windows.
vim.opt.winborder = 'single'

-- 24-bit RGB colors.
vim.opt.termguicolors = true

-- File encoding.
vim.opt.fileencoding = 'utf-8'

-- Case-insensitive searching unless uppercase letters in term.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Modern native completion.
vim.opt.completeopt = { 'fuzzy', 'menuone', 'noinsert', 'popup' }

-- Complete longest common string.
vim.opt.wildmode = 'longest:full'

-- Ignore case when completing file names.
vim.opt.wildignorecase = true

-- Shorten some cmdline messages.
vim.opt.shortmess = 'clF'

-- Don't show current mode in cmdline.
vim.opt.showcmd = false

-- Min rows/columns to keep visible when scrolling.
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Don't soft-wrap lines nor split words on wrapping.
vim.opt.wrap = false
vim.opt.linebreak = true

-- Indent soft-wrapped lines.
vim.opt.breakindent = true

-- Enable relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line.
vim.opt.cursorline = true

-- Visual markers for column widths.
vim.opt.colorcolumn = { 80, 100, 120 }

-- Always have a single column for signs.
vim.opt.signcolumn = 'yes:1'

-- No swap files and no backup.
vim.opt.swapfile = false
vim.opt.writebackup = false

-- Enable undo.
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Split below/to the right.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Use 4 spaces instead of tabs by default.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Round indent to multiples of shiftwidth.
vim.opt.shiftround = true

-- Perform smart autoindenting on new line creation.
vim.opt.smartindent = true

-- Only j/k can move across lines.
vim.opt.whichwrap = ''

-- Show some hidden characters.
vim.opt.list = true
vim.opt.listchars = {
    tab = '>·',
    leadmultispace = '▏   ',
    extends = '▸',
    precedes = '◂',
    trail = '·',
}

-- Enable folding based on Treesitter.
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Only really nested code is auto-folded.
vim.opt.foldlevel = 20
