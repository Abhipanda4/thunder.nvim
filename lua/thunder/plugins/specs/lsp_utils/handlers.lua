local M = {}

M.setup = function()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = "rounded",
      title = " Docs "
    }
  )
end

return M
