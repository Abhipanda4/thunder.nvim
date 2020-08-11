" ============================================================================
" Name:        autoload/thunder/init.vim
" Description: All lazy loaded function definitions
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ============================================================================

function! s:get_color_palette() abort
  let l:colors = {
    \ "red": "#e06c75",
    \ "light_red": "#ff869a",
    \ "dark_red": "#BE5046",
    \ "green": "#C3E88D",
    \ "yellow": "#ffcb6b",
    \ "dark_yellow": "#eaa263",
    \ "bright_yellow": "#ff8000",
    \ "blue": "#82b1ff",
    \ "purple": "#c792ea",
    \ "cyan1": "#89DDFF",
    \ "cyan2": "#00ff99",
    \ "white": "#bfc7d5",
    \ "black": "#292d3e",
    \ "light_black": "#383c54",
    \ "dark_black": "#181A1F",
    \ "cursor_grey": "#212637",
    \ "comment_grey": "#697098",
    \ "gutter_fg_grey": "#4B5263",
    \ "visual_grey": "#3E4452",
    \ "menu_grey": "#333746",
    \ "special_grey": "#3B4048",
    \ }
  return l:colors
endfunction

function! thunder#init#setup() abort
  " Disable netrw loading, use NERDTree for better experience
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1

  " set python3 host program
  let g:python3_host_prog = '/usr/local/bin/python3.8'

  let g:thunder_color_palette = s:get_color_palette()
endfunction

function! thunder#init#on_enter() abort
  setlocal winhighlight=
endfunction

function! thunder#init#on_exit() abort
  if (&filetype != 'qf')
    setlocal winhighlight=LineNr:StatuslineNC
  endif
endfunction
