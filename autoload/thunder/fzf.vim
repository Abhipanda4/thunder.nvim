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
        \ 'fg+': g:thunder_color_palette.yellow,
        \ 'bg+': g:thunder_color_palette.black,
        \ 'hl+': g:thunder_color_palette.cyan2,
        \ 'fg': g:thunder_color_palette.white,
        \ 'bg': g:thunder_color_palette.black,
        \ 'hl': g:thunder_color_palette.blue,
        \ 'gutter': g:thunder_color_palette.black,
        \ 'info': g:thunder_color_palette.purple,
        \ 'prompt': g:thunder_color_palette.purple,
        \ 'pointer': g:thunder_color_palette.blue
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


function! s:GetFZFFileOptions() abort
    let l:colors = s:GetFZFPalette()
    if strlen(l:colors) > 0
        let l:colors = " --color=" .. "'" .. s:GetFZFPalette() .. "'"
    endif

    let l:display = " --margin 2,5,2,5 --reverse --info=inline --header=''"
    let l:extra = " --prompt='F> ' --marker='> '"
    let l:actions = " --expect=ctrl-v,ctrl-x"
    return l:colors .. l:display .. l:extra .. l:actions
endfunction


function! thunder#fzf#FuzzyFindFiles() abort
    call fzf#run({
        \ 'source': s:GetCmdForFilesList(),
        \ 'options': s:GetFZFFileOptions(),
        \ 'window': 'lua require("lightning/windows").open_centered_float_with_border()',
        \ 'sink*': function('s:FZFFileHandler')
        \ })
endfunction
