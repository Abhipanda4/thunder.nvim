local M = {}

function M.setup()
  vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '●',
        [vim.diagnostic.severity.WARN] = '●',
        [vim.diagnostic.severity.INFO] = '●',
        [vim.diagnostic.severity.HINT] = '●',
      },
    },
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'always',
      scope = 'cursor',
      header = '',
      -- TODO: format for error msg display
    },
    update_in_insert = false,
  })

  vim.api.nvim_create_augroup("LspDiagnostics", { clear = true })
  vim.api.nvim_create_autocmd('DiagnosticChanged', {
    group = "LspDiagnostics",
    callback = function()
      vim.diagnostic.setloclist({
        open = false,
        title = 'Diagnostics',
      })
    end,
  })
end

return M
