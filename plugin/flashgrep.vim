command! -nargs=+ -complete=dir -bar Grep lua require"thunder.grepper".perform_grep(<q-args>)
nnoremap <leader>g :Grep<space>
