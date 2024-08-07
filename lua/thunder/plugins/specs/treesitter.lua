local M = {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,

  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      ensure_installed = { "go", "gomod", "lua", "python", "proto", "cpp", "vimdoc", "vim" },
      highlight = { enable = true, },
      indent = { enable = true },
      sync_install = false,
    })
  end,
}

return M
