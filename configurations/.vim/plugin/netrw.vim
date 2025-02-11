"" Configurations for Netrw.

" Hide the banner.
let g:netrw_banner = 0

" Show relative line numbers in Netrw buffers.
let g:netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

" Keep the current directory and the browsing directory synced, avoiding the
" move files error.
let g:netrw_keepdir = 0

" Change the copy command to enable recursive copy of directories.
let g:netrw_localcopydircmd = 'cp -r'
