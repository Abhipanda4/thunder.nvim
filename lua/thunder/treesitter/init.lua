local ts = require("nvim-treesitter.configs")
local M = {}

function M.setup()
  ts.setup {
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = {"lua"},
      use_languagetree = true
    }
  }
end

return M
