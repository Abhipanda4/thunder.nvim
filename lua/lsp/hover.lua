local vim = vim
local windows = require("thunder/windows")

local MAX_WIDTH = 100
local MAX_HEIGHT = 20

local function custom_hover_handler(_, method, result)
   if not (result and result.contents) then
      return
   end

   local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
   markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
   if vim.tbl_isempty(markdown_lines) then
      return
   end
   local preview_opts = {
      width = MAX_WIDTH,
      height = MAX_HEIGHT,
      border_style = "thin",
   }
   local win_opts = windows.make_floating_window_at_cursor(preview_opts)
   vim.api.nvim_buf_set_lines(win_opts.primary_bufnr, 0, -1, true, markdown_lines)
   vim.lsp.util.close_preview_autocmd({"CursorMovedI", "BufHidden", "BufLeave", "CursorMoved", "WinScrolled"}, win_opts.primary_winnr)
   vim.lsp.util.close_preview_autocmd({"CursorMovedI", "BufHidden", "BufLeave", "CursorMoved", "WinScrolled"}, win_opts.border_winnr)
end

local function fancy_preview()
   local params = vim.lsp.util.make_position_params()
   vim.lsp.buf_request(0,'textDocument/hover', params, custom_hover_handler)
end

return {
   fancy_preview = fancy_preview
}
