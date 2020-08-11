-- Adapted from -
-- https://github.com/haorenW1025/config/blob/ad72e0dac1a0cc7906c0468cdc49176a7b05a820/.config/nvim/lua/status-line.lua#L1
local vim = vim
local MODE_MAP = setmetatable({
   ['n'] = 'N',
   ['no'] = 'N',
   ['r'] = 'N',
   ['v'] = 'V',
   ['V'] = 'V',
   ['^V'] = 'V',
   ['s'] = 'S',
   ['S'] = 'S',
   ['^S'] = 'S',
   ['i'] = 'I',
   ['ic'] = 'I',
   ['ix'] = 'I',
   ['R'] = 'R',
   ['Rv'] = 'R',
   ['c'] = 'C',
   ['cv'] = 'E',
   ['ce'] = 'E',
}, {
   -- fix weird issues
   __index = function(_, _)
      return 'VB'
   end
})
local M = {}

function M.mode_component()
   local mode = vim.api.nvim_get_mode()['mode']
   return MODE_MAP[mode]
end

function M.filename_component(_, buf_handle, only_name)
   local filename = vim.api.nvim_buf_get_name(buf_handle)
   if filename == "" or filename == nil then
      return "[No Name]"
   end
   local cwd = vim.loop.cwd()
   if only_name then
      local paths = vim.split(filename, '/')
      return paths[#paths]
   else
      if string.match(filename, cwd) then
         return string.gsub(filename, cwd .. '/', '')
      else
         return string.gsub(filename, vim.fn.environ()['HOME'], '~')
      end
   end
end

function M.readonly_component(_, buf_handle)
   if vim.api.nvim_buf_get_option(buf_handle, 'readonly') then return 'RO' end
   return ''
end

function M.modified_component(_, buf_handle)
   if not vim.api.nvim_buf_get_option(buf_handle, 'modifiable') then return '-' end
   if vim.api.nvim_buf_get_option(buf_handle, 'modified') then return '+' end
   return ''
end

function M.diagnostics_component(_, buf_handle)
   if vim.tbl_isempty(vim.lsp.buf_get_clients(buf_handle)) then return nil end

   local n_error = vim.lsp.util.buf_diagnostics_count([[Error]])
   local n_warning = vim.lsp.util.buf_diagnostics_count([[Warning]])
   local n_hint = vim.lsp.util.buf_diagnostics_count([[Hint]])
   local n_info = vim.lsp.util.buf_diagnostics_count([[Information]])

   -- TODO: LSP is not yet initialized here?
   if n_error == nil then return nil end

   local diagnostics = nil
   local n_diagnostics = n_error + n_warning + n_hint + n_info
   if n_diagnostics == 0 then
      diagnostics = {
         ['ok'] = ' ',
         ['errors'] = '',
         ['warnings'] = '',
         ['hints'] = '',
      }
   else
      diagnostics = {
         ['ok'] = '',
      }
      if n_error == 0 then
         diagnostics['errors'] = ''
      else
         diagnostics['errors'] = string.format('%d ', n_error)
      end
      if n_warning == 0 then
         diagnostics['warnings'] = ''
      else
         diagnostics['warnings'] = string.format('%d ', n_warning)
      end
      if n_hint + n_info == 0 then
         diagnostics['hints'] = ''
      else
         diagnostics['hints'] = string.format('%d ', n_hint + n_info)
      end
   end
   return diagnostics
end

function M.filetype_component(_, buf_handle)
   local filetype = vim.api.nvim_buf_get_option(buf_handle, 'filetype')
   if filetype == '' then return 'no ft' end
   return filetype
end

function M.lineinfo_component(win_handle, buf_handle)
   local cursor_pos = vim.api.nvim_win_get_cursor(win_handle)
   local curr_line = cursor_pos[1]
   local col_idx = 1 + cursor_pos[2]
   local num_lines = vim.api.nvim_buf_line_count(buf_handle)
   return string.format('%2dC, %d/%dL', col_idx, curr_line, num_lines)
end

return M
