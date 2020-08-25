let g:nvim_tree_width = 40
let g:nvim_tree_side = 'left'
let g:nvim_tree_ignore = ['.git', 'node_modules']
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_hide_dotfiles = 1
let g:nvim_tree_bindings = {
      \ 'edit':          ['<cr>', 'o'],
      \ 'edit_vsplit':   '<c-v>',
      \ 'edit_split':    '<c-x>',
      \ 'edit_tab':      '<c-t>',
      \ 'close_node':    ['<s-cr>', '<bs>'],
      \ 'preview':       '<Tab>',
      \ 'create':        'a',
      \ 'remove':        'd',
      \ 'rename':        'r',
      \ 'cut':           'x',
      \ 'copy':          'y',
      \ 'paste':         'p',
      \ 'prev_git_item': '[c',
      \ 'next_git_item': ']c',
      \ }

nnoremap <silent> <leader>n :NvimTreeToggle<cr>
