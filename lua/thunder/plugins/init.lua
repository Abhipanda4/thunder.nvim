local M = {}


function M.setup()
   require('packer').startup(function()
      -- Plugin Manager
      use { 'wbthomason/packer.nvim' }

      -- LSP manager
      use { 'neovim/nvim-lspconfig' }

      -- Lua based autocompletion engine
      use { 'hrsh7th/nvim-compe' }

      -- Code formatter, LSP is not fully equipped for formatting
      use { 'mhartington/formatter.nvim' }

      -- Better semantic syntax highlight with treesitter
      use { 'nvim-treesitter/nvim-treesitter' }

      -- Icon pack for neovim
      use { 'kyazdani42/nvim-web-devicons' }

      -- Simple nononsense fuzzy finder
      use { 'junegunn/fzf' }

      -- painless f/F usage
      use { 'rhysd/clever-f.vim' }

      -- Auto pairing of brackets/quotes
      use { 'tmsvg/pear-tree' }

      -- Operate with surrounding brackets/quotes easily
      use { 'machakann/vim-sandwich' }

      -- Easy comment/uncomment code blocks
      use { 'preservim/nerdcommenter' }

      -- Amplify the power of text objects
      use { 'wellle/targets.vim' }

      -- Forget nohlsearch with smart on/off of search matches
      use { 'romainl/vim-cool' }

      -- Crisp indentlines with extension to blank lines too...
      use { 'lukas-reineke/indent-blankline.nvim', branch='lua'}

      -- Interactive undo management
      use { 'mbbill/undotree', cmd={'UndotreeToggle'} }

      -- File tree viewer
      use { 'kyazdani42/nvim-tree.lua' }

      -- Statusline
      use {
         'glepnir/galaxyline.nvim',
         branch = 'main',
         config = function() require'thunder/statusline' end,
         requires = {'kyazdani42/nvim-web-devicons', opt = true}
      }

      -- Profiler
      use { 'norcalli/profiler.nvim', opt = true }
   end)
end

return M
