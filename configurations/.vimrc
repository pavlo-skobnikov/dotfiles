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

""" Exit early when evaluating this file w/ IdeaVim.
if has('ide')
    finish
endif

""" Options specific to Vim.

" Set 'bash' as the Vim's shell.
set shell=/bin/bash

" More modern completion.
set completeopt=menu,menuone,preview,noinsert,fuzzy

" Enable Tab-completion for command mode.
set wildmenu

" Time out key codes.
" NOTE: Helps with having to press Escape/C-[ twice to exit INSERT.
set ttimeout
set ttimeoutlen=0

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

" Use 4-space tabs by default.
set expandtab
set shiftround
set shiftwidth=4
set tabstop=4

" Perform autoindenting when writing text.
set smartindent

" Don't split words on wrapping by default.
set linebreak

" Enable displaying hidden characters.
set list listchars=tab:>·,leadmultispace:▏\ \ \ ,extends:▸,precedes:◂,trail:·

" Indent-based folding w/o any folding when entering the buffer.
set foldenable
set foldlevel=99
set foldmethod=indent

" Enable syntax highlighting.
syntax on

"" Custom cursor shapes.
let &t_SI = "\<Esc>[6 q" " INSERT - |
let &t_EI = "\<Esc>[2 q" " Other modes - █

" The most polite colorscheme to ever exist 🐾
" The colorschemes are taken from https://github.com/catppuccin/vim
" All credit goes to the creators, maintainers, and contributors of the
" `catppuccin/vim` project 🙏
if empty(system('defaults read -g AppleInterfaceStyle 2> /dev/null'))
    " Name: catppuccin_latte.vim

    set background=dark
    hi clear

    if exists('syntax on')
        syntax reset
    endif

    let g:colors_name='catppuccin_latte'
    set t_Co=256

    let s:rosewater = "#DC8A78"
    let s:flamingo = "#DD7878"
    let s:pink = "#EA76CB"
    let s:mauve = "#8839EF"
    let s:red = "#D20F39"
    let s:maroon = "#E64553"
    let s:peach = "#FE640B"
    let s:yellow = "#DF8E1D"
    let s:green = "#40A02B"
    let s:teal = "#179299"
    let s:sky = "#04A5E5"
    let s:sapphire = "#209FB5"
    let s:blue = "#1E66F5"
    let s:lavender = "#7287FD"

    let s:text = "#4C4F69"
    let s:subtext1 = "#5C5F77"
    let s:subtext0 = "#6C6F85"
    let s:overlay2 = "#7C7F93"
    let s:overlay1 = "#8C8FA1"
    let s:overlay0 = "#9CA0B0"
    let s:surface2 = "#ACB0BE"
    let s:surface1 = "#BCC0CC"
    let s:surface0 = "#CCD0DA"

    let s:base = "#EFF1F5"
    let s:mantle = "#E6E9EF"
    let s:crust = "#DCE0E8"

    function! s:hi(group, guisp, guifg, guibg, gui, cterm)
    let cmd = ""
    if a:guisp != ""
        let cmd = cmd . " guisp=" . a:guisp
    endif
    if a:guifg != ""
        let cmd = cmd . " guifg=" . a:guifg
    endif
    if a:guibg != ""
        let cmd = cmd . " guibg=" . a:guibg
    endif
    if a:gui != ""
        let cmd = cmd . " gui=" . a:gui
    endif
    if a:cterm != ""
        let cmd = cmd . " cterm=" . a:cterm
    endif
    if cmd != ""
        exec "hi " . a:group . cmd
    endif
    endfunction


    call s:hi("Normal", "NONE", s:text, s:base, "NONE", "NONE")
    call s:hi("Visual", "NONE", "NONE", s:surface1,"bold", "bold")
    call s:hi("Conceal", "NONE", s:overlay1, "NONE", "NONE", "NONE")
    call s:hi("ColorColumn", "NONE", "NONE", s:surface0, "NONE", "NONE")
    call s:hi("Cursor", "NONE", s:base, s:text, "NONE", "NONE")
    call s:hi("lCursor", "NONE", s:base, s:text, "NONE", "NONE")
    call s:hi("CursorIM", "NONE", s:base, s:text, "NONE", "NONE")
    call s:hi("CursorColumn", "NONE", "NONE", s:mantle, "NONE", "NONE")
    call s:hi("CursorLine", "NONE", "NONE", s:surface0, "NONE", "NONE")
    call s:hi("Directory", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("DiffAdd", "NONE", s:base, s:green, "NONE", "NONE")
    call s:hi("DiffChange", "NONE", s:base, s:yellow, "NONE", "NONE")
    call s:hi("DiffDelete", "NONE", s:base, s:red, "NONE", "NONE")
    call s:hi("DiffText", "NONE", s:base, s:blue, "NONE", "NONE")
    call s:hi("EndOfBuffer", "NONE", "NONE", "NONE", "NONE", "NONE")
    call s:hi("ErrorMsg", "NONE", s:red, "NONE", "bolditalic"    , "bold,italic")
    call s:hi("VertSplit", "NONE", s:crust, "NONE", "NONE", "NONE")
    call s:hi("Folded", "NONE", s:blue, s:surface1, "NONE", "NONE")
    call s:hi("FoldColumn", "NONE", s:overlay0, s:base, "NONE", "NONE")
    call s:hi("SignColumn", "NONE", s:surface1, s:base, "NONE", "NONE")
    call s:hi("IncSearch", "NONE", s:surface1, s:pink, "NONE", "NONE")
    call s:hi("CursorLineNR", "NONE", s:lavender, "NONE", "NONE", "NONE")
    call s:hi("LineNr", "NONE", s:surface1, "NONE", "NONE", "NONE")
    call s:hi("MatchParen", "NONE", s:peach, "NONE", "bold", "bold")
    call s:hi("ModeMsg", "NONE", s:text, "NONE", "bold", "bold")
    call s:hi("MoreMsg", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("NonText", "NONE", s:overlay0, "NONE", "NONE", "NONE")
    call s:hi("Pmenu", "NONE", s:overlay2, s:surface0, "NONE", "NONE")
    call s:hi("PmenuSel", "NONE", s:text, s:surface1, "bold", "bold")
    call s:hi("PmenuSbar", "NONE", "NONE", s:surface1, "NONE", "NONE")
    call s:hi("PmenuThumb", "NONE", "NONE", s:overlay0, "NONE", "NONE")
    call s:hi("Question", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("QuickFixLine", "NONE", "NONE", s:surface1, "bold", "bold")
    call s:hi("Search", "NONE", s:pink, s:surface1, "bold", "bold")
    call s:hi("SpecialKey", "NONE", s:subtext0, "NONE", "NONE", "NONE")
    call s:hi("SpellBad", "NONE", s:base, s:red, "NONE", "NONE")
    call s:hi("SpellCap", "NONE", s:base, s:yellow, "NONE", "NONE")
    call s:hi("SpellLocal", "NONE", s:base, s:blue, "NONE", "NONE")
    call s:hi("SpellRare", "NONE", s:base, s:green, "NONE", "NONE")
    call s:hi("StatusLine", "NONE", s:text, s:mantle, "NONE", "NONE")
    call s:hi("StatusLineNC", "NONE", s:surface1, s:mantle, "NONE", "NONE")
    call s:hi("StatusLineTerm", "NONE", s:text, s:mantle, "NONE", "NONE")
    call s:hi("StatusLineTermNC", "NONE", s:surface1, s:mantle, "NONE", "NONE")
    call s:hi("TabLine", "NONE", s:surface1, s:mantle, "NONE", "NONE")
    call s:hi("TabLineFill", "NONE", "NONE", s:mantle, "NONE", "NONE")
    call s:hi("TabLineSel", "NONE", s:green, s:surface1, "NONE", "NONE")
    call s:hi("Title", "NONE", s:blue, "NONE", "bold", "bold")
    call s:hi("VisualNOS", "NONE", "NONE", s:surface1, "bold", "bold")
    call s:hi("WarningMsg", "NONE", s:yellow, "NONE", "NONE", "NONE")
    call s:hi("WildMenu", "NONE", "NONE", s:overlay0, "NONE", "NONE")
    call s:hi("Comment", "NONE", s:overlay0, "NONE", "NONE", "NONE")
    call s:hi("Constant", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Identifier", "NONE", s:flamingo, "NONE", "NONE", "NONE")
    call s:hi("Statement", "NONE", s:mauve, "NONE", "NONE", "NONE")
    call s:hi("PreProc", "NONE", s:pink, "NONE", "NONE", "NONE")
    call s:hi("Type", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("Special", "NONE", s:pink, "NONE", "NONE", "NONE")
    call s:hi("Underlined", "NONE", s:text, s:base, "underline", "underline")
    call s:hi("Error", "NONE", s:red, "NONE", "NONE", "NONE")
    call s:hi("Todo", "NONE", s:base, s:flamingo, "bold", "bold")

    call s:hi("String", "NONE", s:green, "NONE", "NONE", "NONE")
    call s:hi("Character", "NONE", s:teal, "NONE", "NONE", "NONE")
    call s:hi("Number", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Boolean", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Float", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Function", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("Conditional", "NONE", s:red, "NONE", "NONE", "NONE")
    call s:hi("Repeat", "NONE", s:red, "NONE", "NONE", "NONE")
    call s:hi("Label", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Operator", "NONE", s:sky, "NONE", "NONE", "NONE")
    call s:hi("Keyword", "NONE", s:pink, "NONE", "NONE", "NONE")
    call s:hi("Include", "NONE", s:pink, "NONE", "NONE", "NONE")
    call s:hi("StorageClass", "NONE", s:yellow, "NONE", "NONE", "NONE")
    call s:hi("Structure", "NONE", s:yellow, "NONE", "NONE", "NONE")
    call s:hi("Typedef", "NONE", s:yellow, "NONE", "NONE", "NONE")
    call s:hi("debugPC", "NONE", "NONE", s:crust, "NONE", "NONE")
    call s:hi("debugBreakpoint", "NONE", s:overlay0, s:base, "NONE", "NONE")

    hi link Define PreProc
    hi link Macro PreProc
    hi link PreCondit PreProc
    hi link SpecialChar Special
    hi link Tag Special
    hi link Delimiter Special
    hi link SpecialComment Special
    hi link Debug Special
    hi link Exception Error
    hi link StatusLineTerm StatusLine
    hi link StatusLineTermNC StatusLineNC
    hi link Terminal Normal
    hi link Ignore Comment

    " Set terminal colors for playing well with plugins like fzf
    let g:terminal_ansi_colors = [
    \ s:subtext1, s:red, s:green, s:yellow, s:blue, s:pink, s:teal, s:surface2,
    \ s:subtext0, s:red, s:green, s:yellow, s:blue, s:pink, s:teal, s:surface1
    \ ]
else
    " Name: catppuccin_frappe.vim

    set background=dark
    hi clear

    if exists('syntax on')
        syntax reset
    endif

    let g:colors_name='catppuccin_frappe'
    set t_Co=256

    let s:rosewater = "#F2D5CF"
    let s:flamingo = "#EEBEBE"
    let s:pink = "#F4B8E4"
    let s:mauve = "#CA9EE6"
    let s:red = "#E78284"
    let s:maroon = "#EA999C"
    let s:peach = "#EF9F76"
    let s:yellow = "#E5C890"
    let s:green = "#A6D189"
    let s:teal = "#81C8BE"
    let s:sky = "#99D1DB"
    let s:sapphire = "#85C1DC"
    let s:blue = "#8CAAEE"
    let s:lavender = "#BABBF1"

    let s:text = "#C6D0F5"
    let s:subtext1 = "#B5BFE2"
    let s:subtext0 = "#A5ADCE"
    let s:overlay2 = "#949CBB"
    let s:overlay1 = "#838BA7"
    let s:overlay0 = "#737994"
    let s:surface2 = "#626880"
    let s:surface1 = "#51576D"
    let s:surface0 = "#414559"

    let s:base = "#303446"
    let s:mantle = "#292C3C"
    let s:crust = "#232634"

    function! s:hi(group, guisp, guifg, guibg, gui, cterm)
    let cmd = ""
    if a:guisp != ""
        let cmd = cmd . " guisp=" . a:guisp
    endif
    if a:guifg != ""
        let cmd = cmd . " guifg=" . a:guifg
    endif
    if a:guibg != ""
        let cmd = cmd . " guibg=" . a:guibg
    endif
    if a:gui != ""
        let cmd = cmd . " gui=" . a:gui
    endif
    if a:cterm != ""
        let cmd = cmd . " cterm=" . a:cterm
    endif
    if cmd != ""
        exec "hi " . a:group . cmd
    endif
    endfunction


    call s:hi("Normal", "NONE", s:text, s:base, "NONE", "NONE")
    call s:hi("Visual", "NONE", "NONE", s:surface1,"bold", "bold")
    call s:hi("Conceal", "NONE", s:overlay1, "NONE", "NONE", "NONE")
    call s:hi("ColorColumn", "NONE", "NONE", s:surface0, "NONE", "NONE")
    call s:hi("Cursor", "NONE", s:base, s:text, "NONE", "NONE")
    call s:hi("lCursor", "NONE", s:base, s:text, "NONE", "NONE")
    call s:hi("CursorIM", "NONE", s:base, s:text, "NONE", "NONE")
    call s:hi("CursorColumn", "NONE", "NONE", s:mantle, "NONE", "NONE")
    call s:hi("CursorLine", "NONE", "NONE", s:surface0, "NONE", "NONE")
    call s:hi("Directory", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("DiffAdd", "NONE", s:base, s:green, "NONE", "NONE")
    call s:hi("DiffChange", "NONE", s:base, s:yellow, "NONE", "NONE")
    call s:hi("DiffDelete", "NONE", s:base, s:red, "NONE", "NONE")
    call s:hi("DiffText", "NONE", s:base, s:blue, "NONE", "NONE")
    call s:hi("EndOfBuffer", "NONE", "NONE", "NONE", "NONE", "NONE")
    call s:hi("ErrorMsg", "NONE", s:red, "NONE", "bolditalic"    , "bold,italic")
    call s:hi("VertSplit", "NONE", s:crust, "NONE", "NONE", "NONE")
    call s:hi("Folded", "NONE", s:blue, s:surface1, "NONE", "NONE")
    call s:hi("FoldColumn", "NONE", s:overlay0, s:base, "NONE", "NONE")
    call s:hi("SignColumn", "NONE", s:surface1, s:base, "NONE", "NONE")
    call s:hi("IncSearch", "NONE", s:surface1, s:pink, "NONE", "NONE")
    call s:hi("CursorLineNR", "NONE", s:lavender, "NONE", "NONE", "NONE")
    call s:hi("LineNr", "NONE", s:surface1, "NONE", "NONE", "NONE")
    call s:hi("MatchParen", "NONE", s:peach, "NONE", "bold", "bold")
    call s:hi("ModeMsg", "NONE", s:text, "NONE", "bold", "bold")
    call s:hi("MoreMsg", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("NonText", "NONE", s:overlay0, "NONE", "NONE", "NONE")
    call s:hi("Pmenu", "NONE", s:overlay2, s:surface0, "NONE", "NONE")
    call s:hi("PmenuSel", "NONE", s:text, s:surface1, "bold", "bold")
    call s:hi("PmenuSbar", "NONE", "NONE", s:surface1, "NONE", "NONE")
    call s:hi("PmenuThumb", "NONE", "NONE", s:overlay0, "NONE", "NONE")
    call s:hi("Question", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("QuickFixLine", "NONE", "NONE", s:surface1, "bold", "bold")
    call s:hi("Search", "NONE", s:pink, s:surface1, "bold", "bold")
    call s:hi("SpecialKey", "NONE", s:subtext0, "NONE", "NONE", "NONE")
    call s:hi("SpellBad", "NONE", s:base, s:red, "NONE", "NONE")
    call s:hi("SpellCap", "NONE", s:base, s:yellow, "NONE", "NONE")
    call s:hi("SpellLocal", "NONE", s:base, s:blue, "NONE", "NONE")
    call s:hi("SpellRare", "NONE", s:base, s:green, "NONE", "NONE")
    call s:hi("StatusLine", "NONE", s:text, s:mantle, "NONE", "NONE")
    call s:hi("StatusLineNC", "NONE", s:surface1, s:mantle, "NONE", "NONE")
    call s:hi("StatusLineTerm", "NONE", s:text, s:mantle, "NONE", "NONE")
    call s:hi("StatusLineTermNC", "NONE", s:surface1, s:mantle, "NONE", "NONE")
    call s:hi("TabLine", "NONE", s:surface1, s:mantle, "NONE", "NONE")
    call s:hi("TabLineFill", "NONE", "NONE", s:mantle, "NONE", "NONE")
    call s:hi("TabLineSel", "NONE", s:green, s:surface1, "NONE", "NONE")
    call s:hi("Title", "NONE", s:blue, "NONE", "bold", "bold")
    call s:hi("VisualNOS", "NONE", "NONE", s:surface1, "bold", "bold")
    call s:hi("WarningMsg", "NONE", s:yellow, "NONE", "NONE", "NONE")
    call s:hi("WildMenu", "NONE", "NONE", s:overlay0, "NONE", "NONE")
    call s:hi("Comment", "NONE", s:overlay0, "NONE", "NONE", "NONE")
    call s:hi("Constant", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Identifier", "NONE", s:flamingo, "NONE", "NONE", "NONE")
    call s:hi("Statement", "NONE", s:mauve, "NONE", "NONE", "NONE")
    call s:hi("PreProc", "NONE", s:pink, "NONE", "NONE", "NONE")
    call s:hi("Type", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("Special", "NONE", s:pink, "NONE", "NONE", "NONE")
    call s:hi("Underlined", "NONE", s:text, s:base, "underline", "underline")
    call s:hi("Error", "NONE", s:red, "NONE", "NONE", "NONE")
    call s:hi("Todo", "NONE", s:base, s:flamingo, "bold", "bold")

    call s:hi("String", "NONE", s:green, "NONE", "NONE", "NONE")
    call s:hi("Character", "NONE", s:teal, "NONE", "NONE", "NONE")
    call s:hi("Number", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Boolean", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Float", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Function", "NONE", s:blue, "NONE", "NONE", "NONE")
    call s:hi("Conditional", "NONE", s:red, "NONE", "NONE", "NONE")
    call s:hi("Repeat", "NONE", s:red, "NONE", "NONE", "NONE")
    call s:hi("Label", "NONE", s:peach, "NONE", "NONE", "NONE")
    call s:hi("Operator", "NONE", s:sky, "NONE", "NONE", "NONE")
    call s:hi("Keyword", "NONE", s:pink, "NONE", "NONE", "NONE")
    call s:hi("Include", "NONE", s:pink, "NONE", "NONE", "NONE")
    call s:hi("StorageClass", "NONE", s:yellow, "NONE", "NONE", "NONE")
    call s:hi("Structure", "NONE", s:yellow, "NONE", "NONE", "NONE")
    call s:hi("Typedef", "NONE", s:yellow, "NONE", "NONE", "NONE")
    call s:hi("debugPC", "NONE", "NONE", s:crust, "NONE", "NONE")
    call s:hi("debugBreakpoint", "NONE", s:overlay0, s:base, "NONE", "NONE")

    hi link Define PreProc
    hi link Macro PreProc
    hi link PreCondit PreProc
    hi link SpecialChar Special
    hi link Tag Special
    hi link Delimiter Special
    hi link SpecialComment Special
    hi link Debug Special
    hi link Exception Error
    hi link StatusLineTerm StatusLine
    hi link StatusLineTermNC StatusLineNC
    hi link Terminal Normal
    hi link Ignore Comment

    " Set terminal colors for playing well with plugins like fzf
    let g:terminal_ansi_colors = [
    \ s:surface1, s:red, s:green, s:yellow, s:blue, s:pink, s:teal, s:subtext1,
    \ s:surface2, s:red, s:green, s:yellow, s:blue, s:pink, s:teal, s:subtext0
    \ ]
endif

" Fixes the incorrect cursor.
normal <C-l>

""" Configurations for Netrw.

" Hide the banner.
let g:netrw_banner = 0

" Show relative line numbers in Netrw buffers.
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

" Keep the current directory and the browsing directory synced, avoiding the
" move files error.
let g:netrw_keepdir = 0

" Change the copy command to enable recursive copy of directories.
let g:netrw_localcopydircmd = 'cp -r'

""" Custom native status lines for active and inactive windows.

"" Active window statusline autocommand.
augroup UpdateStatusLineForActiveWindow
  autocmd!
  autocmd WinEnter,BufEnter * let &l:statusline = '%t  %r%m%=%y  %l,%c    %P'
augroup END

"" Inactive window statusline autocommand.
augroup UpdateStatusLineForInactiveWindow
  autocmd!
  autocmd WinLeave,BufLeave * let &l:statusline = '%t  %r%m%=[%{winnr()}]%=%y  %l,%c    %P'
augroup END

""" Custom commands for Vim.

"" Update the tab spaces and all the related options correctly.
function! SetTabSpaces(spaces_count)
  " Set shiftwidth and tabstop.
  exec "set shiftwidth=" . a:spaces_count
  exec "set tabstop=" . a:spaces_count

  " Prepare dynamic multispace value.
  let leadmultispace_part = "leadmultispace:▏" .
    \ repeat('\ ', a:spaces_count - 1)

  " Set listchars with dynamic leadmultispace.
  exec "set listchars=extends:▸,precedes:◂,trail:·,tab:>·,"
    \ . leadmultispace_part
endfunction

" Create a user command for setting tab spaces
command! -nargs=1 SetTabSpaces call SetTabSpaces(<args>)

""" Maps section.

" Open current directory and project root maps via Netrw.
map - :Explore<Cr>
map _ :Explore ./<Cr>

" Close current tab.
map <C-w>t :tabclose<Cr>
map <C-w>T :tabclose!<Cr>

" Echo currently selected file's path.
map <Leader>f :echo expand('%:p')<Cr>

" Open LazyGit.
map <Leader>g :call system('lazygit')<Cr>

" Open LazyDocker.
map <Leader>d :call system('lazydocker')<Cr>

" Fuzzy find project files.
function! FzfSelectFile()
    " Define commands for retrieving files and fzf.
    let list_project_files_command = 'fd --unrestricted --exclude ".git/" --type=file'
    let fzf_with_preview_command = 'fzf --style=minimal' .
        \ ' --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' .
        \ ' --preview "bat --color=always --style=numbers --line-range=:500 {}"'

    " Compose commands.
    let select_file_command = list_project_files_command . ' | ' . fzf_with_preview_command

    " Run the command.
    let selected_file = system(select_file_command)

    " Check if a file was selected (system() returns non-empty string on success).
    if !empty(selected_file)
        " fzf might return a trailing newline, remove it
        let selected_file = substitute(selected_file, '\n', '', '')

        " Use execute and fnameescape() to open the file safely
        " fnameescape() handles special characters in filenames
        execute 'edit ' . fnameescape(selected_file)
    endif

    " Force redraw the screen.
    execute 'redraw!'
endfunction

nnoremap <Leader>. :call FzfSelectFile()<Cr>

" Grep through project files.
function! GrepFiles(search_term)
    " Define commands for retrieving files and fzf.
    let ripgrep_search_command = 'rg --color=always --line-number --no-heading --smart-case "' . a:search_term . '"'
    let fzf_with_preview_command = 'fzf --style=minimal' .
        \ ' --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down' .
        \ ' --preview "bat --color=always {1} --highlight-line {2} --style=numbers"' .
        \ ' --preview-window "+{2}+3/3,~3"' .
        \ ' --ansi --color "hl:-1:underline,hl+:-1:underline:reverse" --delimiter ":"'
    " Compose commands.
    let select_file_command = ripgrep_search_command . ' | ' . fzf_with_preview_command

    " Run the command.
    let selected_file_and_cursor_pos = system(select_file_command)


    " Check if a file was selected (system() returns non-empty string on success).
    if !empty(selected_file_and_cursor_pos)
        " Remove trailing newline from the result.
        let selected_file_and_cursor_pos = substitute(selected_file_and_cursor_pos, '\n\+$', '', '')

        " Parse the selection: expected format is "filename:line:column:text"
        " We want filename and line number.
        let parts = split(selected_file_and_cursor_pos, ':', 3)
        if len(parts) >= 2
            let filename = parts[0]
            let lnum = str2nr(parts[1])
            " Open the file and jump to the line.
            execute 'edit +' . lnum . ' ' . fnameescape(filename)
        else
            " Fallback: just open the file if parsing fails.
            execute 'edit ' . fnameescape(selected_file_and_cursor_pos)
        endif
    endif

    " Force redraw the screen.
    execute 'redraw!'
endfunction

nnoremap <Leader>/ :call GrepFiles(input('grep: '))<Cr>

