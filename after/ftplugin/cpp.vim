function! s:ToggleSourceAndHeader() abort
  let l:extension = expand("%:e")
  let l:target_extension = ""
  if l:extension ==# "cpp"
    let l:target_extension = "h"
  else
    let l:target_extension = "cpp"
  endif
  let l:new_destination = expand("%:r") .. "." .. l:target_extension
  if (!filereadable(l:new_destination))
    echom "File " .. l:new_destination .. " does not exist!"
    return
  endif
  let l:cmd = "normal! :edit " .. l:new_destination .. "<cr>"
  execute l:cmd
endfunction

command! -nargs=0 ToggleCPPSourceAndHeader call s:ToggleSourceAndHeader()
nnoremap <buffer> <leader>l :ToggleCPPSourceAndHeader<cr>
