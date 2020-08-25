local vim = vim
local M = {}

function M.setup()
   vim.cmd 'packadd paq-nvim'
   local paq = require('paq-nvim').paq

   -- Let Paq manage itself
   paq { 'savq/paq-nvim', opt=true }

   -- Neovim specialities
   paq { 'neovim/nvim-lspconfig' }

   -- Lua based autocompletion engine
   paq { 'hrsh7th/nvim-compe' }

   -- Code formatter, LSP is not fully equipped for formatting
   paq { 'mhartington/formatter.nvim' }

   -- Better semantic syntax highlight with treesitter
   paq { 'nvim-treesitter/nvim-treesitter' }

   -- Fuzzy Finder
   paq { 'junegunn/fzf' }

   -- painless f/F usage
   paq { 'rhysd/clever-f.vim' }

   -- Auto pairing of brackets/quotes
   paq { 'tmsvg/pear-tree' }

   -- Operate with surrounding brackets/quotes easily
   paq { 'machakann/vim-sandwich' }

   -- Easy comment/uncomment code blocks
   paq { 'preservim/nerdcommenter' }

   -- Amplify the power of text objects
   paq { 'wellle/targets.vim' }

   -- Forget nohlsearch with smart on/off of search matches
   paq { 'romainl/vim-cool' }

   -- Interactive undo management
   paq { 'mbbill/undotree', cmd={'UndotreeToggle'} }

   -- File tree viewer
   paq { 'kyazdani42/nvim-web-devicons' }
   paq { 'kyazdani42/nvim-tree.lua' }
end

return M
