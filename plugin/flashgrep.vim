command! -nargs=+ -complete=dir -bar Grep lua require"flashgrep".flashgrep(<q-args>)
