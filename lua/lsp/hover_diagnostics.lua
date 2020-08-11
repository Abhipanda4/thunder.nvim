local vim = vim
local MAX_SEVERITY_WIDTH = 8
local SEVERITY_MAP = {'ERROR', 'WARN', 'INFO', 'HINT'}
local HIGHLIGHT_MAP = {
   'LspDiagnosticsError',
   'LspDiagnosticsWarning',
   'LspDiagnosticsInfo',
   'LspDiagnosticsHint'
}
local M = {}

function M.show_diagnostics_in_hover()
   -- Adapted from -
   -- https://github.com/neovim/neovim/blob/459800db43146680ef75f3cd251dd4d57d72bf48/runtime/lua/vim/lsp/util.lua#L949

   local display = { "Diagnostics" }
   local highlights = { "Title" }

   local line_diagnostics = vim.lsp.util.get_line_diagnostics()
   if vim.tbl_isempty(line_diagnostics) then return end
   -- TODO: sort diagnostics a/c to severity

   for _, diagnostic in ipairs(line_diagnostics) do
      table.insert(highlights, HIGHLIGHT_MAP[diagnostic.severity])

      -- Format for messages: [SEVERITY] message
      local severity = SEVERITY_MAP[diagnostic.severity]
      if not severity then
         severity = 'ERROR'
      end
      severity = "[" .. severity .. "]"
      severity = severity .. string.rep(" ",
      MAX_SEVERITY_WIDTH - string.len(severity))
      local line = severity .. diagnostic.message
      table.insert(display, line)
   end

   local bufnr, _ = vim.lsp.util.open_floating_preview(
      display, 'plaintext')

   -- Hover is filled with text now, add highlighting
   for idx, hi in ipairs(highlights) do
      if idx == 1 then
         vim.api.nvim_buf_add_highlight(bufnr, -1, hi, idx - 1, 0, -1)
      else
         vim.api.nvim_buf_add_highlight(bufnr, -1, hi, idx - 1, 0, MAX_SEVERITY_WIDTH)
      end
   end
end

return M
