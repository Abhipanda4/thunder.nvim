" ====================================================================
" Name:        after/ftplugin/qf.vim
" Description: Quickfix buffer specific settings
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ====================================================================

setlocal norelativenumber
setlocal cursorline
setlocal nobuflisted
setlocal nowrap

wincmd J
nnoremap <buffer> o <cr><C-w>p
