command! -nargs=0 FuzzyFindFiles call thunder#fzf#FuzzyFindFiles()
nnoremap <silent> <leader>f :FuzzyFindFiles<cr>
