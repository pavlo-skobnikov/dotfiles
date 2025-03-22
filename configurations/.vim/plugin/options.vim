"" Options specific to Vim.

" General terminal/file options.
set termguicolors
set fileencoding="utf-8"

" Shorten some lines and bytes information in the cmdline.
set shortmess="lF"
" When set case is ignored when completing file names and directories.
set wildignorecase
" Always show statusline.
set laststatus=2

" Don't create a backup, swap, or backup files.
set nobackup
set noswapfile
set nowritebackup

" Enable persistent undo by saving the undo history to a file.
set undofile
set undolevels=10000
set undodir=~/.local/state/vim/undo

" Split below/to the right.
set splitbelow
set splitright

" Use 2-space tabs by default.
set expandtab
set shiftround
set shiftwidth=2
set tabstop=2

" Perform autoindenting when writing text.
set smartindent

" Don't split words on wrapping by default.
set linebreak

" Enable displaying hidden characters.
set list listchars=tab:>·,leadmultispace:▏\ ,extends:▸,precedes:◂,trail:·

" Indent-based folding w/o any folding when entering the buffer.
set foldenable
set foldlevel=99
set foldmethod=indent

" Enable syntax highlighting.
syntax on

" Custom cursor shapes.
let &t_SI = "\<Esc>[6 q" " INSERT - |
" Block in other modes
let &t_EI = "\<Esc>[2 q" " Other modes - █

" The most polite colorscheme to ever exist 🐾
" Why use redis and not the system() function?
" -> My work MacOS machine refuses to do any system calls for built-in Vim :(
redir => s:terminal_theme
silent! echo $BAT_THEME
redir END

if s:terminal_theme =~ "Catppuccin Latte"
  colorscheme catppuccin_latte
else
  colorscheme catppuccin_frappe
endif

