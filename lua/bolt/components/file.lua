local vim = vim
local M = {}

function M.filepath(win_opts)
   local filepath = vim.api.nvim_buf_get_name(win_opts.bufnr)
   if filepath == "" or filepath == nil then
      return "[No Name]"
   end
   local cwd = vim.loop.cwd()
   if string.match(filepath, cwd) then
      return string.gsub(filepath, cwd .. '/', '')
   else
      return string.gsub(filepath, vim.fn.environ()['HOME'], '~')
   end
end

function M.filename(win_opts)
   local filepath = M.filepath(win_opts)
   local subpaths = vim.split(filepath, '/')
   return subpaths[#subpaths]
end

function M.filetype(win_opts)
   return vim.api.nvim_buf_get_option(win_opts.buffer_handle,
                                                'filetype')
end

function M.special_filetype(win_opts)
   local ft = vim.api.nvim_buf_get_option(win_opts.buffer_handle,
                                                'filetype')
   if ft ~= 'qf' then return ft end
   return 'Quickfix List'
end

function M.is_file_modified(win_opts)
   if vim.api.nvim_buf_get_option(win_opts.buffer_handle, 'readonly') then
      return ''
   end
   if not vim.api.nvim_buf_get_option(win_opts.buffer_handle, 'modifiable') then
      return ''
   end
   if vim.api.nvim_buf_get_option(win_opts.buffer_handle, 'modified') then
      return ''
   end
   return ''
end

function M.cursor_info(win_opts)
   local cursor_pos = vim.api.nvim_win_get_cursor(win_opts.window_handle)
   local curr_line = cursor_pos[1]
   local col_idx = 1 + cursor_pos[2]
   local num_lines = vim.api.nvim_buf_line_count(win_opts.buffer_handle)
   return string.format('%2dC, %d/%dL', col_idx, curr_line, num_lines)
end

return M
