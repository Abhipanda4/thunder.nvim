" ====================================================================
" Name:        plugin/vanilla_mappings.vim
" Description: keymaps that do not depend on 3rd party plugins
" Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
" ====================================================================

" Exchange functionality of : & ;
nnoremap : ;
vnoremap : ;
nnoremap ; :
vnoremap ; :

" Make j and k move by wrapped line unless a count was entered
" like `10j`, in which case it behaves normally.
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
vnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

" Easy jumping to beginning and end of line
nnoremap H ^
nnoremap L g_
vnoremap H ^
vnoremap L g_

" Disable the arrow keys for good :)
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Right> <NOP>
inoremap <Left> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Right> <NOP>
nnoremap <Left> <NOP>

" Handle splits the right way
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" search results appear in middle of buffer
nnoremap n nzz
nnoremap N Nzz

" search with * for visual selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

" Visual shifting dows not exit visual mode
vnoremap < <gv
vnoremap > >gv

" Follow tradition of C & D
nnoremap Y y$

" Better scrolling
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

" use terminal style mappings in cmd mode
cnoremap <C-a> <home>
cnoremap <C-e> <end>

" Insert blank lines with count
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Quit vim easily
nnoremap <leader>q :quit!<cr>
nnoremap <leader>Q :qall!<cr>

" close all clutter windows easily
nnoremap <silent> <leader>o :only<cr>
nnoremap <silent> <leader>p :pclose<cr>

" Quickfix & Location list mappings
" TODO: make next/previous more intelligent, perhaps use lua for these
nnoremap <silent> gq :call thunder#quickfix#ToggleQuickfix()<cr>
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprevious<cr>

nnoremap <silent> gl :call thunder#quickfix#ToggleLoclist()<cr>
nnoremap <silent> ]l :call thunder#quickfix#JumpToNextLoclistItem()<cr>
nnoremap <silent> [l :call thunder#quickfix#JumpToPrevLoclistItem()<cr>

" tab navigation
nnoremap <silent> ]t :tabnext<cr>
nnoremap <silent> [t :tabprevious<cr>

" replace easily
nnoremap <leader>r :%s//g<Left><Left>

" Project wide grep
command! -nargs=+ -complete=dir Grep lua require('lightning/grepper').AsyncGrep(<q-args>)
nnoremap <leader>g :Grep<space>
