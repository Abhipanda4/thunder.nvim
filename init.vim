" ====================================================================
" Name:        init.vim
" Description: Entry point to nvim configuration
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ====================================================================

scriptencoding utf-8

call thunder#init#setup()

" set colorscheme
set background=dark
colorscheme thunder

" Use space key as leader
let g:mapleader = "\<Space>"
