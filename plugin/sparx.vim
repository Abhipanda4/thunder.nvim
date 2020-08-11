if exists('g:loaded_tree') | finish | endif
let g:loaded_sparx = 1

augroup Sparx
  autocmd!
  autocmd BufWinLeave,WinClosed * if &ft == 'sparx' | lua require('sparx').close()
augroup END

nnoremap <silent> <leader>s :lua require('sparx').toggle()<cr>
nnoremap <silent> <leader>a :lua require('sparx').open_current_file()<cr>
