"" Custom native status lines for active and inactive windows.

" Active window statusline autocommand.
augroup UpdateStatusLineForActiveWindow
  autocmd!
  autocmd WinEnter,BufEnter * let &l:statusline = '%f  %r%m%=%y  %l,%c    %P'
augroup END

" Inactive window statusline autocommand.
augroup UpdateStatusLineForInactiveWindow
  autocmd!
  autocmd WinLeave,BufLeave * let &l:statusline = '%t  %r%m%=%y  [%{winnr()}]  '
augroup END
