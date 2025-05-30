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
nnoremap <silent> <C-l> :nohlsearch<Cr>:redraw!<Cr>

" Center screen on page movement.
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Replay q register macro.
noremap Q @q

" Quickly replace (substitute) text.
nnoremap R :%s/
vnoremap R :s/

" Quickly execute Normal commands.
nnoremap ga :%normal 
vnoremap ga :normal 

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

" Change around/inside double quotes.
nnoremap caq ca"
nnoremap ciq ci"

""" Exit early when evaluating this file w/ IdeaVim.
if has('ide')
    finish
endif

""" Options specific to Vim.

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

"" Colorscheme shenanigans.
colorscheme habamax

" A helper function to resolve Vim's current colorscheme.
function! GetCurrentVimColorscheme()
    if exists('g:colors_name')
        return g:colors_name
    else
        return 'default'
    endif
endfunction

" A helper function to resolve the current system appearance into the
" appropriate option value used by Vim.
function! GetSystemAppearanceAsColorscheme()
    if empty(system('defaults read -g AppleInterfaceStyle 2> /dev/null'))
        return 'quiet'
    else
        return 'habamax'
    endif
endfunction

" Start a continuous asynchronous job to update the colorscheme if system
" appeance differs from the desired Vim colorscheme.
function! ResolveSystemAppearanceUpdatingColorscheme(timer)
    let l:target_colorscheme = GetSystemAppearanceAsColorscheme()
    let l:current_colorscheme = GetCurrentVimColorscheme()

    " Exit early if everything matches.
    if l:target_colorscheme == l:current_colorscheme
        return
    endif

    " Update Vim's colorscheme.
    execute 'colorscheme ' . l:target_colorscheme

    " `quiet` required some special treatment.
    if l:target_colorscheme == 'quiet'
        execute 'set background=light'
    endif

    " Also, reload terminal colors.
    call system('set-terminal-colors.sh')
endfunction

call timer_start(2000, 'ResolveSystemAppearanceUpdatingColorscheme', { 'repeat': -1 })

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

" Helper function to open TUI application and force redraw Vim.
function! OpenTUIApplication(command)
    execute "call system('" . a:command . "')"

    execute 'redraw!'
endfunction

" Open LazyGit.
map <Leader>g :call OpenTUIApplication('lazygit')<Cr>

" Open LazyDocker.
map <Leader>d :call OpenTUIApplication('lazydocker')<Cr>

" Fuzzy find project files.
function! FzfSelectFile()
    let list_project_files_command = "fd --unrestricted --exclude '.git/' --type=file '' '" . getcwd(-1) . "'"
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

" Fuzzy find project directories.
function! FzfSelectDirectory()
    " Define commands for retrieving directories and fzf.
    let list_project_directories_command = "fd --unrestricted --exclude '.git/' --type=directory '' '" . getcwd(-1) . "'"
    let fzf_command = 'fzf --style=minimal' .
        \ ' --bind ctrl-y:preview-up,ctrl-e:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'

    " Compose commands.
    let select_directory_command = list_project_directories_command . ' | ' . fzf_command

    " Run the command.
    let selected_directory = system(select_directory_command)

    " Check if a directory was selected (system() returns non-empty string on success).
    if !empty(selected_directory)
        " fzf might return a trailing newline, remove it
        let selected_directory = substitute(selected_directory, '\n', '', '')

        " Use execute and fnameescape() to open the file safely
        " fnameescape() handles special characters in filenames
        execute 'Explore ' . fnameescape(selected_directory)
    endif

    " Force redraw the screen.
    execute 'redraw!'
endfunction

nnoremap <Leader>- :call FzfSelectDirectory()<Cr>

" Grep through project files.
function! GrepFiles(search_term)
    " Define commands for retrieving files and fzf.
    let ripgrep_search_command = 'rg --hidden --iglob "!.git/" --color=always --line-number --no-heading --smart-case "' .
        \ a:search_term . '" "' . getcwd(-1) . '"'
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
vnoremap <Leader>/ "zygv:call GrepFiles('z')<Cr>

