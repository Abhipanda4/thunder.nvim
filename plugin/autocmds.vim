function! RestoreCursor()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup restore_cursor
  autocmd!
  autocmd BufWinEnter * call RestoreCursor()
augroup END

function s:OnFocusLost()
  if (&filetype != 'qf')
    setlocal winhighlight=LineNr:Statusline
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

augroup yank_highlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END
