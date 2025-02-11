"" Custom commands for Vim.

" Update the tab spaces and all the related options correctly.
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
