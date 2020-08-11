" ====================================================================
" Name:        init.vim
" Description: Entry point to nvim configuration
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ====================================================================

" Initialize all global variables for configuration
call thunder#init#setup()

" set colorscheme
set background=dark
colorscheme thunder

" Use space key as leader
let mapleader = "\<Space>"

" List of all 3rd party plugins used
call plug#begin(stdpath('data') . '/vendor/')

    " Auto-complete & diagnostics using LSP
    Plug 'neovim/nvim-lsp'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}
    Plug 'Shougo/deoplete-lsp'

    " Better semantics based syntax highlighting
    Plug 'nvim-treesitter/nvim-treesitter'

    " General Editing
    Plug 'rhysd/clever-f.vim'
    Plug 'tmsvg/pear-tree'
    Plug 'machakann/vim-sandwich'
    Plug 'preservim/nerdcommenter'
    Plug 'wellle/targets.vim'
    Plug 'romainl/vim-cool'

    " Project Explorer
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

    " Interactive undo management
    Plug 'mbbill/undotree', { 'on': ['UndotreeToggle'] }

call plug#end()
