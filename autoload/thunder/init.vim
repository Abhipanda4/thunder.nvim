" ============================================================================
" Name:        autoload/thunder/init.vim
" Description: All lazy loaded function definitions
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ============================================================================

function! s:disable_distribution_plugins() abort
  " Disable loading of some inbuilt plugins
  let g:loaded_gzip              = 1
  let g:loaded_tar               = 1
  let g:loaded_tarPlugin         = 1
  let g:loaded_zip               = 1
  let g:loaded_zipPlugin         = 1
  let g:loaded_getscript         = 1
  let g:loaded_getscriptPlugin   = 1
  let g:loaded_vimball           = 1
  let g:loaded_vimballPlugin     = 1
  let g:loaded_matchit           = 0
  let g:loaded_matchparen        = 0
  let g:loaded_2html_plugin      = 1
  let g:loaded_logiPat           = 1
  let g:loaded_rrhelper          = 1
  let g:loaded_netrw             = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1
  let g:loaded_netrwFileHandlers = 1
endfunction

function! thunder#init#setup() abort
  call s:disable_distribution_plugins()
  let g:loaded_python_provider = 0
  let g:python3_host_prog = '/usr/local/bin/python3'
endfunction
