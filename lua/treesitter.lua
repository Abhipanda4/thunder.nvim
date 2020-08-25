local vim = vim
local ts = require('nvim-treesitter.configs')
local M = {}

function M.setup()
   ts.setup {
      ensure_installed = { 'lua', 'python', 'c', 'cpp', 'json' },
      highlight = { enable = true },
   }
end

return M
