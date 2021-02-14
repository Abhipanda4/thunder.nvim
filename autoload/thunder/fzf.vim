" ============================================================================
" Name:        autoload/thunder/fzf.vim
" Description: FZF helper functions
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ============================================================================


function! s:GetCmdForFilesList() abort
    return "fd --color never --type f"
endfunction


function! s:GetFZFPalette() abort
    let l:fzf_colors = {
        \ 'fg+': g:color_palette.yellow,
        \ 'bg+': g:color_palette.menu_grey,
        \ 'hl+': g:color_palette.dark_yellow,
        \ 'fg': g:color_palette.white,
        \ 'bg': g:color_palette.menu_grey,
        \ 'hl': g:color_palette.blue,
        \ 'gutter': g:color_palette.menu_grey,
        \ 'info': g:color_palette.purple,
        \ 'pointer': g:color_palette.yellow,
        \ 'prompt': g:color_palette.purple,
        \ 'header': g:color_palette.purple
        \ }
    return join(map(items(l:fzf_colors), 'v:val[0] . ":" . v:val[1]'), ",")
endfunction


function! s:FZFFileHandler(lines) abort
  if empty(a:lines)
    return
  endif
  let cmd = get({ 'ctrl-t': 'tabedit',
                \ 'ctrl-x': 'split',
                \ 'ctrl-v': 'vsplit' }, remove(a:lines, 0), 'e')
  for item in a:lines
    execute cmd escape(item, ' %#\')
  endfor
endfunction


function s:GetCWDPrompt() abort
  let l:cwd = substitute(getcwd(), $HOME, '~', '')
  return "  " .. l:cwd .. "/"
endfunction

function! s:GetFZFFileOptions() abort
    let l:colors = s:GetFZFPalette()
    if strlen(l:colors) > 0
        let l:colors = " --color=" .. "'" .. s:GetFZFPalette() .. "'"
    endif

    let l:display = " --margin 2,2,2,2 --reverse --info=hidden --header=''"
    let l:extra = " --no-multi --prompt='➤  ' --pointer='➤ ' --cycle"
    let l:header = " --header='\n" .. s:GetCWDPrompt() .. "\n\n'"
    let l:actions = " --expect=ctrl-v,ctrl-x"
    return l:colors .. l:display .. l:extra .. l:actions .. l:header
endfunction


function! thunder#fzf#FuzzyFindFiles() abort
    call fzf#run({
        \ 'source': s:GetCmdForFilesList(),
        \ 'options': s:GetFZFFileOptions(),
        \ 'window': 'lua require("thunder/utils/windows").make_centered_floating_window()',
        \ 'sink*': function('s:FZFFileHandler')
        \ })
endfunction
