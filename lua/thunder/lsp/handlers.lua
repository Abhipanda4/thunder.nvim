local vim = vim
local M = {}

local function diagnostics_handler(...)
  local default_callback =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      signs = true,
      underline = false,
      virtual_text = false,
      update_in_insert = false
    }
  )
  default_callback(...)
  vim.lsp.diagnostic.set_loclist(
    {
      open_loclist = false
    }
  )
end

local function hover_handler(...)
  local default_callback =
    vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = "single"
    }
  )
  default_callback(...)
end

function M.setup()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = diagnostics_handler
  vim.lsp.handlers["textDocument/hover"] = hover_handler
end

return M
