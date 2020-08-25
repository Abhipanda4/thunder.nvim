" ============================================================================
" File:        plugin/autocommands.vim
" Description: Collection of all custom autocommands
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ============================================================================

function! RestoreCursor()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup restore_cursor
  " Restore cursor position on entering any buffer
  autocmd!
  autocmd BufWinEnter * call RestoreCursor()
augroup END

function s:OnFocusLost()
  if (&filetype != 'qf')
    setlocal winhighlight=LineNr:StatuslineNC
  endif
endfunction

function s:OnFocusGained()
  setlocal winhighlight=
endfunction

augroup focus_events
  autocmd!
  autocmd WinEnter,BufEnter,VimEnter * call s:OnFocusGained()
  autocmd WinLeave,BufLeave * call s:OnFocusLost()
augroup END

augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

augroup AutoCompletion
  autocmd!
  autocmd BufEnter * lua require'completion'.on_attach()
augroup END
