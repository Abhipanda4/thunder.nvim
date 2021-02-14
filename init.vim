" ====================================================================
" Name:        init.vim
" Description: Entry point to nvim configuration
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ====================================================================

" Set encoding
scriptencoding utf-8

" Set some global variables
call thunder#init#setup()

" Set colorscheme
colorscheme thunder

" Set leader key for mappings
let g:mapleader = "\<Space>"

" Setup lua modules
lua require("thunder")
