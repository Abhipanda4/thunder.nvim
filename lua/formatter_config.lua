local vim = vim
local formatter = require("formatter")
local M = {}

function M.setup()
  formatter.setup(
    {
      filetype = {
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
    }
  )
  vim.api.nvim_buf_set_keymap(
    0,
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
