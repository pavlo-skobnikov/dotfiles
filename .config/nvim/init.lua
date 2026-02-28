-- [[ Plugins 📲 ]]
vim.pack.add {
  -- Theme 🐈
  { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
  -- Code highlighting and editing 🎨
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.align',
  'https://github.com/nvim-mini/mini.operators',
  'https://github.com/nvim-mini/mini.splitjoin',
  'https://github.com/nvim-mini/mini.surround',
  -- Miscellaneous 🌀
  'https://github.com/nvim-mini/mini.diff',
  'https://github.com/nvim-mini/mini.clue',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-mini/mini.pick',
  'https://github.com/nvim-mini/mini.extra',
  'https://github.com/stevearc/oil.nvim',
  -- Language support (code actions, formatting, etc.) 🧠
  'https://github.com/neovim/nvim-lspconfig',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '1.*' },
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/mason-org/mason.nvim',
  -- AI 🤖
  'https://github.com/Exafunction/windsurf.vim',
}

vim.cmd.packadd 'cfilter'
vim.cmd.packadd 'nvim.undotree'
vim.cmd.packadd 'nvim.difftool'

-- [[ Options and configurations ⚙️ ]]
-- Leader keys.
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Miscellaneous configurations.
vim.opt.termguicolors = true
vim.opt.fileencoding = 'utf-8'
vim.opt.visualbell = true

-- No timeouts for keychord sequences.
vim.opt.timeout = false
vim.opt.ttimeoutlen = 0

-- Square borders for pop-up windows and properly aligned window separators.
vim.opt.winborder = 'single'
vim.opt.pumborder = 'single'
vim.opt.fillchars = { vert = '▕' }

-- Better command line completion.
vim.opt.wildmode = 'noselect:lastused,full'
vim.opt.wildoptions = 'pum,fuzzy'
vim.opt.wildignorecase = true

-- Better :grep.
vim.opt.grepprg = 'rg --vimgrep --no-messages --smart-case'

-- Increase quickfix and location list persistent history.
vim.opt.chistory = 50
vim.opt.lhistory = 50

-- Case-insensitive searching unless uppercase letters in the command line.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- A less intrusive completion menu.
vim.opt.pumheight = 15

-- Min rows/columns to keep visible when scrolling.
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 3

-- Don't soft-wrap lines nor split words on wrapping.
vim.opt.wrap = false
vim.opt.linebreak = true

-- Only j/k can move across lines.
vim.opt.whichwrap = ''

-- Enable relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Always have a single column for signs.
vim.opt.signcolumn = 'number'

-- Visual markers for the current line and set columns.
vim.opt.cursorline = true
vim.opt.colorcolumn = { 80, 100, 120 }

-- Prepend a '<WINDOW_NUMBER>:' part to the statusline.
vim.opt.statusline:prepend '%{winnr()}:'

-- No swap files and no backup.
vim.opt.swapfile = false
vim.opt.writebackup = false

-- Enable undo.
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Split below/to the right.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Indentation setup.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.breakindent = true

-- Display some hidden characters.
vim.opt.list = true
vim.opt.listchars = {
  tab = '>·',
  leadmultispace = '▏   ',
  extends = '▸',
  precedes = '◂',
  trail = '·',
}

-- Load External plugin configurations ⚙️
require 'plugin-configuration.catppuccin'
require 'plugin-configuration.treesitter'
require 'plugin-configuration.mini'
require 'plugin-configuration.oil'
require 'plugin-configuration.lspconfig'
require 'plugin-configuration.blink'
require 'plugin-configuration.conform'
require 'plugin-configuration.mason'

-- [[ Keymaps ⌨️ ]]

vim.keymap.set({ 'n', 'x' }, '<Tab>', '<C-^>', { desc = 'Switch to last accessed buffer' })

vim.keymap.set({ 'n', 'x' }, '<C-d>', '<C-d>zz', { desc = 'Half-page down and center' })
vim.keymap.set({ 'n', 'x' }, '<C-u>', '<C-u>zz', { desc = 'Half-page up and center' })

vim.keymap.set({ 'n', 'x' }, '<C-f>', 'zL', { desc = 'Half-screen right' })
vim.keymap.set({ 'n', 'x' }, '<C-b>', 'zH', { desc = 'Half-screen left' })

-- [ Goto 🏃‍♂️ ]
vim.keymap.set({ 'n', 'x' }, 'gd', "<Cmd>Pick lsp scope='definition'<Cr>", { desc = 'Go to definition' })
vim.keymap.set({ 'n', 'x' }, 'gD', "<Cmd>Pick lsp scope='declaration'<Cr>", { desc = 'Go to declaration' })
vim.keymap.set({ 'n', 'x' }, 'gy', "<Cmd>Pick lsp scope='type_definition'<Cr>", { desc = 'Go to type definition' })

vim.keymap.set('n', 'gE', '<Cmd>set opfunc=v:lua.NormalOperatorFunction<Cr>g@', { desc = 'Execute {cmd}' })
vim.keymap.set('x', 'gE', ':normal ', { desc = 'Execute {cmd}' })

vim.keymap.set('n', 'gR', '<Cmd>set opfunc=v:lua.SubstituteOperatorFunction<Cr>g@', { desc = 'Replace /w :substitute' })
vim.keymap.set('x', 'gR', ':normal ', { desc = 'Replace /w :substitute' })

vim.keymap.set({ 'n', 'x' }, 'g/', '<Cmd>Pick buf_lines<Cr>', { desc = 'Search buffer lines' })

-- [ Leader 👑 ]

-- (Code) actions 👨‍💻
vim.keymap.set({ 'n', 'x' }, '<Leader>aa', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ar', vim.lsp.buf.rename, { desc = 'Rename' })

vim.keymap.set(
  { 'n', 'x' },
  '<Leader>ad',
  "<Cmd>Pick diagnostic scope='current'<Cr>",
  { desc = 'Search document diagnostics' }
)
vim.keymap.set(
  { 'n', 'x' },
  '<Leader>aD',
  "<Cmd>Pick diagnostic scope='all'<Cr>",
  { desc = 'Search workspace diagnostics' }
)

vim.keymap.set(
  { 'n', 'x' },
  '<Leader>as',
  function() vim.lsp.buf.typehierarchy 'subtypes' end,
  { desc = 'Inspect subtypes' }
)
vim.keymap.set(
  { 'n', 'x' },
  '<Leader>aS',
  function() vim.lsp.buf.typehierarchy 'supertypes' end,
  { desc = 'Inspect supertypes' }
)

vim.keymap.set({ 'n', 'x' }, '<Leader>ac', vim.lsp.buf.incoming_calls, { desc = 'Navigate incoming calls' })
vim.keymap.set({ 'n', 'x' }, '<Leader>aC', vim.lsp.buf.outgoing_calls, { desc = 'Navigate outgoing calls' })

-- Chatbots 🤖
vim.keymap.set({ 'n', 'x' }, '<Leader>c', '<Cmd>TmuxFocusOrOpen claude<Cr>', { desc = 'claude' })
vim.keymap.set({ 'n', 'x' }, '<Leader>C', '<Cmd>TmuxFocusOrOpen claude --continue<Cr>', { desc = 'claude --continue' })

-- Explore file tree 🌳
vim.keymap.set({ 'n', 'x' }, '<Leader>e', '<Cmd>Oil<Cr>', { desc = 'Explore current directory' })
vim.keymap.set({ 'n', 'x' }, '<Leader>E', '<Cmd>Oil .<Cr>', { desc = 'Explore workspace root' })

-- Files 📁
vim.keymap.set({ 'n', 'x' }, '<Leader>fr', ':<C-u>saveas ', { desc = 'Rename' })
vim.keymap.set({ 'n', 'x' }, '<Leader>fy', ':YankFilePath f<Cr>', { desc = 'Yank path [+pos] @f' })
vim.keymap.set({ 'n', 'x' }, '<Leader>fY', ':YankFilePath +<Cr>', { desc = 'Yank path [+pos] @+' })

-- Git 🐙
vim.keymap.set({ 'n', 'x' }, '<Leader>gg', '<Cmd>TmuxFocusOrOpen lazygit<Cr>', { desc = 'Open lazygit' })
vim.keymap.set({ 'n', 'x' }, '<Leader>gb', '<Cmd>Pick git_branches<Cr>', { desc = 'Search branches' })
vim.keymap.set({ 'n', 'x' }, '<Leader>gl', '<Cmd>Pick git_commits<Cr>', { desc = 'Search commit log' })
vim.keymap.set({ 'n', 'x' }, '<Leader>gf', "<Cmd>Pick git_commits path='%'<Cr>", { desc = 'Search file commit log' })
vim.keymap.set({ 'n', 'x' }, '<Leader>gh', '<Cmd>Pick git_hunks<Cr>', { desc = 'Search unstaged hunks' })

-- Jumps list 🦘
vim.keymap.set({ 'n', 'x' }, '<Leader>j', "<Cmd>Pick list scope='jump'<Cr>", { desc = 'Search jumplist' })

-- Location list 📍
vim.keymap.set({ 'n', 'x' }, '<Leader>l', "<Cmd>Pick list scope='location'<Cr>", { desc = 'Search loclist' })

-- Marks (using arglist) ❗
vim.keymap.set({ 'n', 'x' }, '<Leader>m', '<Cmd>Pick arguments<Cr>', { desc = 'Search args' })
vim.keymap.set({ 'n', 'x' }, '<Leader>M', '<Cmd>$argadd % | argdedupe<Cr>', { desc = 'Add file to argslist' })

-- Quickfix 🚨
vim.keymap.set({ 'n', 'x' }, '<Leader>q', "<Cmd>Pick list scope='quickfix'<Cr>", { desc = 'Search qflist' })
vim.keymap.set({ 'n', 'x' }, '<Leader>Q', '<Cmd>Pick qflist_history<Cr>', { desc = 'Search qflist history' })

-- Symbols 🤑
vim.keymap.set(
  { 'n', 'x' },
  '<Leader>ss',
  "<Cmd>Pick lsp scope='document_symbol'<Cr>",
  { desc = 'Search document symbols' }
)
vim.keymap.set(
  { 'n', 'x' },
  '<Leader>sS',
  "<Cmd>Pick lsp scope='workspace_symbol_live'<Cr>",
  { desc = 'Search project symbols' }
)
vim.keymap.set({ 'n', 'x' }, '<Leader>sr', "<Cmd>Pick lsp scope='references'<Cr>", { desc = 'Find references' })
vim.keymap.set(
  { 'n', 'x' },
  '<Leader>si',
  "<Cmd>Pick lsp scope='implementation'<Cr>",
  { desc = 'Go to implementation' }
)

vim.keymap.set({ 'n', 'x' }, '<Leader>sh', vim.lsp.buf.document_highlight, { desc = 'Highlight usages' })
vim.keymap.set({ 'n', 'x' }, '<Leader>sH', vim.lsp.buf.clear_references, { desc = 'Remove symbol highlights' })

-- Tools 🧰
vim.keymap.set({ 'n', 'x' }, '<Leader>td', '<Cmd>TmuxFocusOrOpen lazydocker<Cr>', { desc = 'lazydocker' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ts', '<Cmd>TmuxFocusOrOpen lazysql<Cr>', { desc = 'lazysql' })
vim.keymap.set({ 'n', 'x' }, '<Leader>tt', '<Cmd>TmuxFocusOrOpen zsh<Cr>', { desc = 'Terminal (zsh)' })

-- Undotree ↩️
vim.keymap.set({ 'n', 'x' }, '<Leader>u', '<Cmd>Undotree<Cr>', { desc = 'Undotree' })

-- Quick search actions 🔍
vim.keymap.set({ 'n', 'x' }, "<Leader>'", '<Cmd>Pick resume<Cr>', { desc = 'Resume last picker' })
vim.keymap.set({ 'n', 'x' }, '<Leader>,', '<Cmd>Pick buffers<Cr>', { desc = 'Switch buffers' })
vim.keymap.set({ 'n', 'x' }, '<Leader>.', "<Cmd>Pick files tool='fd'<Cr>", { desc = 'Find files' })
vim.keymap.set({ 'n', 'x' }, '<Leader>/', '<Cmd>Pick grep_live<Cr>', { desc = 'Grep project' })
vim.keymap.set({ 'n', 'x' }, '<Leader>:', '<Cmd>Pick history<Cr>', { desc = 'Search command/search history' })
