local sparx_controller = require('sparx/lib/controller')
local vim = vim
local M = {}

function M.open()
   if not sparx_controller.is_window_initialized() then
      sparx_controller.open_tree_view()
   end
end

function M.close()
   if sparx_controller.is_window_initialized() then
      sparx_controller.close_tree_view()
   end
end

function M.open_current_file()
   local curr_file = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
   if sparx_controller.is_window_initialized() then
      sparx_controller.close_tree_view()
   end
   sparx_controller.open_tree_view()
   sparx_controller.expand_till_filepath(curr_file)
end

function M.focus()
   if not sparx_controller.is_window_initialized() then return end
   vim.api.nvim_set_current_win(sparx_controller.get_win_handle())
end

function M.toggle()
   if sparx_controller.is_window_initialized() then
      sparx_controller.close_tree_view()
   else
      sparx_controller.open_tree_view()
   end
end

return M
