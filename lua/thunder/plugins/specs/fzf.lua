local M = {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      fzf_colors = true,
      winopts = { preview = { default = "bat" } },
      defaults = {
        file_icons = true,
        git_icons = false,
      },
      files = {
        prompt = 'Files❯ ',
        git_icons = false,
      },
      previewers = {
        bat = {
          theme = "Catppuccin Mocha"
        }
      }
    })
  end,
  keys = {
    {
      "<leader>f",
      "<cmd>lua require('fzf-lua').files({ resume = false, header=false }) <cr>",
      desc="Fuzzy file founder"
    },
    {
      "<leader>s",
      "<cmd>lua require('fzf-lua').lsp_workspace_symbols({ resume = false, header=false }) <cr>",
      desc="Fuzzy symbol search"
    }
  }
}

return M
