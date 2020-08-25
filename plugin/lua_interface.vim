" Load lua based settings
lua require("plugins").setup()

" Setup LSP for better project analysis
lua require("lsp").setup()

" Setup Treesitter for semantic syntax highlighting
lua require("treesitter").setup()

" Setup formatter for specific filetypes separate from LSP
lua require("formatter_config").setup()

lua require("autocompletion").setup()
