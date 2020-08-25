function! s:Comparator(item1, item2)
  if (a:item1.lnum <= a:item2.lnum && a:item1.col < a:item2.col)
    return -1
  elseif (a:item1.lnum == a:item2.lnum && a:item1.col == a:item2.col)
    return 0
  endif
  return 1
endfunction

function! s:get_sorted_loclist()
  let l:loclist = getloclist(0)
  return sort(l:loclist, function("s:Comparator"))
endfunction

function! thunder#quickfix#ToggleQuickfix() abort
    for i in range(1, winnr('$'))
        let l:bnum = winbufnr(i)
        if getbufvar(l:bnum, '&buftype') == 'quickfix'
            if getwininfo(win_getid(i))[0].loclist != 1
              cclose
              return
            endif
        endif
    endfor
    copen
endfunction


function! thunder#quickfix#ToggleLoclist() abort
    for i in range(1, winnr('$'))
        let l:bnum = winbufnr(i)
        if getbufvar(l:bnum, '&buftype') == 'quickfix'
            if getwininfo(win_getid(i))[0].loclist
                lclose
                return
            endif
        endif
    endfor
    try | lwindow | catch | echo "No location List available" | endtry
endfunction

function! thunder#quickfix#JumpToNextLoclistItem() abort
  let loclist_items = s:get_sorted_loclist()
  if len(loclist_items) == 0
    echohl Error | echo 'No items in Location list for current buffer' | echohl None
    return
  end
  let curr_row = line('.')
  let curr_col = col('.')

  for item in loclist_items
    if (item.lnum > curr_row)
      call cursor(item.lnum, item.col)
      return
    elseif (item.lnum == curr_row && item.col > curr_col)
      call cursor(item.lnum, item.col)
      return
    endif
  endfor
  call cursor(loclist_items[0].lnum, loclist_items[0].col)
endfunction

function! thunder#quickfix#JumpToPrevLoclistItem() abort
  let loclist_items = s:get_sorted_loclist()
  if len(loclist_items) == 0
    echohl Error | echo 'No items in Location list for current buffer' | echohl None
    return
  end
  let curr_row = line('.')
  let curr_col = col('.')
  for item in reverse(loclist_items)
    if (item.lnum < curr_row)
      call cursor(item.lnum, item.col)
      return
    elseif (item.lnum == curr_row && item.col < curr_col)
      call cursor(item.lnum, item.col)
      return
    endif
  endfor
  call cursor(loclist_items[0].lnum, loclist_items[0].col)
endfunction
