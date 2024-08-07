local M = {
  "nvim-lualine/lualine.nvim",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  opts = require("thunder.plugins.specs.lualine.config").get_lualine_config(),
}

return M
