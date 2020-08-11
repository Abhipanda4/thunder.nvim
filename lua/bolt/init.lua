local vim = vim
local segments = require('bolt/segments')
local SPECIAL_BUFFERS = {
   ['sparx'] = 'Sparx',
   ['undotree'] = 'UndoTree',
   ['quickfix'] = 'Quickfix List',
   ['loclist'] = 'Location List'
}
local M = {}

local function add_padding(str)
   return ' ' .. str .. ' '
end

local function merge_components(components)
   local non_empty_components = vim.fn.filter(components, 'v:val != ""')
   return add_padding(vim.fn.join(non_empty_components, ' | '))
end

local function redraw_colors(curr_mode)
   if curr_mode == 'N' or curr_mode == 'C' then
      vim.api.nvim_command('highlight link ModeHighlight User1')
   elseif curr_mode == 'I' then
      vim.api.nvim_command('highlight link ModeHighlight User2')
   elseif curr_mode == 'V' or curr_mode == 'VB' then
      vim.api.nvim_command('highlight link ModeHighlight User3')
   elseif curr_mode == 'R' then
      vim.api.nvim_command('highlight link ModeHighlight User4')
   end
end

local function create_left_active_statusline(win_handle, buf_handle)
   local stl = ''
   local curr_mode = segments.mode_component()
   redraw_colors(curr_mode)
   stl = stl .. '%#ModeHighlight#' .. add_padding(curr_mode) .. '%0*'
   local file_prop_components = {
      segments.filename_component(win_handle, buf_handle, true),
      segments.readonly_component(win_handle, buf_handle),
      segments.modified_component(win_handle, buf_handle),
   }
   local file_props = merge_components(file_prop_components)
   stl = stl .. '%5*' .. file_props .. '%0*'
   return stl
end

local function create_right_active_statusline(win_handle, buf_handle)
   local stl = ''
   local diagnostics = segments.diagnostics_component(win_handle, buf_handle)
   if diagnostics ~= nil then
      stl = stl .. '%#LspDiagnosticsError#' .. diagnostics.errors .. '%0*'
      stl = stl .. '%#LspDiagnosticsWarning#' .. diagnostics.warnings .. '%0*'
      stl = stl .. '%#LspDiagnosticsHint#' .. diagnostics.hints .. '%0*'
      stl = stl .. '%#LspDiagnosticsOk#' .. diagnostics.ok .. '%0*'
   end

   local filetype = segments.filetype_component(win_handle, buf_handle)
   stl = stl .. '%5*' .. add_padding(filetype) .. '%0*'
   local lineinfo = segments.lineinfo_component(win_handle, buf_handle)
   stl = stl .. '%#ModeHighlight#' .. add_padding(lineinfo) .. '%0*'
   return stl
end

local function create_left_inactive_statusline(win_handle, buf_handle)
   local stl = ''
   local file_prop_components = {
      segments.filename_component(win_handle, buf_handle, false),
      segments.readonly_component(win_handle, buf_handle),
      segments.modified_component(win_handle, buf_handle)
   }
   local file_props = merge_components(file_prop_components)
   stl = stl .. '%6*' .. file_props .. '%0*'
   return stl
end

local function create_right_inactive_statusline(win_handle, buf_handle)
   local stl = ''
   local lineinfo = segments.lineinfo_component(win_handle, buf_handle)
   stl = stl .. '%6*' .. add_padding(lineinfo) .. '%0*'
   return stl
end

local function get_speacial_buffer_name(win_handle, buf_handle)
   local filetype = vim.api.nvim_buf_get_option(buf_handle, 'filetype')
   if filetype == 'qf' then
      local wininfo = vim.fn.getwininfo(win_handle)
      if wininfo[1].loclist == 1 then return 'loclist' else return 'quickfix' end
   end
   return filetype
end

local function special_buffer_active_statusline(win_handle, buf_handle)
   local special_bufname = get_speacial_buffer_name(win_handle, buf_handle)
   if SPECIAL_BUFFERS[special_bufname] ~= nil then
      local stl = ''
      stl = '%#ModeHighlight#'
      stl = stl .. add_padding(SPECIAL_BUFFERS[special_bufname])
      stl = stl .. '| - %0*'
      return stl
   end
   return nil
end

local function special_buffer_inactive_statusline(win_handle, buf_handle)
   local special_bufname = get_speacial_buffer_name(win_handle, buf_handle)
   if special_bufname == nil then return nil end
   if SPECIAL_BUFFERS[special_bufname] ~= nil then
      local stl = ''
      stl = stl .. '%6*' .. add_padding(SPECIAL_BUFFERS[special_bufname])
      stl = stl .. '| - %0*'
      return stl
   end
   return nil
end

function M.active_statusline(win_handle)
   local buf_handle = vim.api.nvim_win_get_buf(win_handle)
   local special_stl = special_buffer_active_statusline(win_handle, buf_handle)
   if special_stl ~= nil then return special_stl end
   local left_active_stl = create_left_active_statusline(win_handle, buf_handle)
   local right_active_stl = create_right_active_statusline(win_handle, buf_handle)
   return left_active_stl .. '%=' .. right_active_stl
end

function M.inactive_statusline(win_handle)
   local buf_handle = vim.api.nvim_win_get_buf(win_handle)
   local special_stl = special_buffer_inactive_statusline(win_handle,
                                                          buf_handle)
   if special_stl ~= nil then return special_stl end
   local left_inactive_stl = create_left_inactive_statusline(win_handle,
                                                             buf_handle)
   local right_inactive_stl = create_right_inactive_statusline(win_handle,
                                                               buf_handle)
   return left_inactive_stl .. '%=' .. right_inactive_stl
end

return M
