local M = {}
local vim = vim

local function populate_loclist(bufnr, diagnostics)
   local items = {}
   for _, diagnostic in ipairs(diagnostics) do
      table.insert(items, {
         bufnr = bufnr,
         lnum = diagnostic.range.start.line + 1,
         col = diagnostic.range.start.character + 1,
         text = diagnostic.message,
      })
   end
   vim.lsp.util.set_loclist(items)
end

function M.setup()
   local method = 'textDocument/publishDiagnostics'
   -- Override default diagnostic callback
   -- https://github.com/neovim/neovim/blob/3ccdbc570d856ee3ff1f64204e352a40b9030ac2/runtime/lua/vim/lsp/callbacks.lua#L67
   vim.lsp.callbacks[method] = function(_, _, result, _)
      if not result then return end
      local uri = result.uri
      local bufnr = vim.uri_to_bufnr(uri)
      if not bufnr then return end
      if not vim.api.nvim_buf_is_loaded(bufnr) then return end

      vim.lsp.util.buf_clear_diagnostics(bufnr)
      vim.lsp.util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
      vim.lsp.util.buf_diagnostics_signs(bufnr, result.diagnostics)
      populate_loclist(bufnr, result.diagnostics)
      vim.api.nvim_command("doautocmd User LspDiagnosticsChanged")
   end
end

return M
