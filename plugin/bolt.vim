if exists('g:loaded_bolt') | finish | endif
let g:loaded_bolt = 1

function ActiveStatusline(winid)
  return luaeval("require('bolt').active_statusline(" . a:winid . ")")
endfunction

function InactiveStatusline(winid)
  return luaeval("require('bolt').inactive_statusline(" . a:winid . ")")
endfunction

function! s:UpdateStatuslines()
  for winnum in range(1, winnr('$'))
    if winnum != winnr()
      call setwinvar(winnum, '&statusline', '%!InactiveStatusline(' . win_getid(winnum) . ')')
    else
      call setwinvar(winnum, '&statusline', '%!ActiveStatusline(' . win_getid(winnum) . ')')
    endif
  endfor
endfunction

augroup bolt
  autocmd!
  autocmd BufWinEnter,WinEnter,BufEnter,BufWinLeave,WinLeave,BufLeave * call s:UpdateStatuslines()
augroup END
