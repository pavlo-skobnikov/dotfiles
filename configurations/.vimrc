""" These configurations are common for both Vim and IdeaVim.

""" Options section.
" leader and localleader keys.
let mapleader = " "
let maplocalleader = "\\"

" Show the current editing mode.
set showmode

" Never timeout when waiting for the next key of a keymap.
set notimeout

" Only j/k can move the cursor to the next/previous line.
set whichwrap=""

" Case-insensitive searching unless upper case letters are present in the search term.
set ignorecase
set smartcase

" Visual markers for column widths and current line.
set colorcolumn=80,100,120
set cursorline

" Enable relative line numbers.
set number
set relativenumber

" Don't soft-wrap lines.
set nowrap

" Minimum number of rows/columns to keep visible when scrolling.
set scrolloff=10
set sidescrolloff=5

" Use visual bell instead of beeping.
set visualbell

" Remember command-line history.
set history=1000

" Search as characters are entered.
set incsearch

" Highlight search results.
set hlsearch

" Wrap around the buffer when searching.
set wrapscan

" Indent soft wrapped lines to match the first line's indent
set breakindent


""" Maps section.
" Clear highlights.
nnoremap <silent> <C-l> :nohlsearch<cr>

" Center screen on page movement.
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Replay q register macro.
noremap Q @q

" Quickly replace (substitute) text.
nnoremap R :%s/
vnoremap R :s/

" Yank 'till the end of the line.
nnoremap Y y$

" Use system clipboard/blackhole register.
noremap gs "+
noremap gb "_

" Add newline above/below.
nnoremap [<space> mzO<esc>`z
vnoremap [<space> <esc>O<esc>gv

nnoremap ]<space> mzo<esc>`z
vnoremap ]<space> <esc>O<esc>gv

