local vim = vim
local formatter = require("formatter")
local M = {}

local function get_filetype_settings()
  local settings = {
    python = {
      function()
        return {
          exe = "yapf",
          args = nil,
          stdin = true
        }
      end
    },
    lua = {
      function()
        return {
          exe = "luafmt",
          args = {"--indent-count", 2, "--stdin"},
          stdin = true
        }
      end
    }
  }
  return settings
end

function M.setup()
  formatter.setup({filetype = get_filetype_settings()})
  vim.api.nvim_set_keymap(
    "n",
    "<leader>=",
    "<cmd>Format<CR>",
    {
      noremap = true,
      silent = true
    }
  )
end

return M
