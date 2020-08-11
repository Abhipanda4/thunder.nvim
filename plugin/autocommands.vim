" ============================================================================
" File:        plugin/autocommands.vim
" Description: Collection of all custom autocommands
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ============================================================================

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup restore_cursor
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

augroup active_numbers
  autocmd!
  autocmd WinEnter,BufEnter,VimEnter * call thunder#init#on_enter()
  autocmd WinLeave,BufLeave * call thunder#init#on_exit()
augroup END
