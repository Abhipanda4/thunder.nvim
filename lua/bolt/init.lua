local vim = vim
local assembler = require('bolt/assembler')
local bolt_utils = require('bolt/utils')
local M = {}
local SPECIAL_FILETYPES = {'NvimTree', 'qf', 'undotree'}

M.statusline = {
   active = {
      left = {
         {
            component = 'mode',
            highlight = 'BoltModeHighlight',
            add_padding = true,
         },
         {
            component = 'filename',
            highlight = 'User5',
            add_padding = true,
         },
         {
            component = 'is_file_modified',
            highlight = 'User6',
         },
      },
      right = {
         {
            component = 'diagnostics_error',
            highlight = 'LspDiagnosticsSignError',
            icon = ' ',
         },
         {
            component = 'diagnostics_warning',
            highlight = 'LspDiagnosticsSignWarning',
            icon = ' ',
         },
         {
            component = 'diagnostics_hint',
            highlight = 'LspDiagnosticsSignHint',
            icon = ' '
         },
         {
            component = 'cursor_info',
            highlight = 'BoltModeHighlight',
            add_padding = true,
         },
      },
   },
   inactive = {
      left = {
         {
            component = 'filename',
            highlight = 'User8',
            add_padding = true,
         },
      },
      right = {
         {
            component = 'cursor_info',
            highlight = 'User8',
            add_padding = true,
         },
      },
   },
   active_special = {
      left = {
         {
            component = 'special_filetype',
            highlight = 'User1',
            add_padding = true,
         },
      },
      right = {}
   },
   inactive_special = {
      left = {},
      right = {}
   }
}

local function get_window_opts(winnr)
   local bufnr = vim.api.nvim_win_get_buf(winnr)
   return {
      winnr = winnr,
      bufnr = bufnr
   }
end

local function is_special_buffer(win_opts)
   local filetype = vim.api.nvim_buf_get_option(win_opts.buffer_handle, 'filetype')
   for _, spcl_ft in ipairs(SPECIAL_FILETYPES) do
      if filetype == spcl_ft then
         return true
      end
   end
   return false
end

local function reset_mode_highlight()
   local curr_mode = bolt_utils.get_current_mode()
   if curr_mode == 'I' then
      vim.api.nvim_command('highlight link BoltModeHighlight User2')
   elseif curr_mode == 'R' then
      vim.api.nvim_command('highlight link BoltModeHighlight User3')
   elseif curr_mode == 'V' or curr_mode == 'VB' then
      vim.api.nvim_command('highlight link BoltModeHighlight User4')
   else
      vim.api.nvim_command('highlight link BoltModeHighlight User1')
   end
end

local function build_active_statusline(win_opts)
   if is_special_buffer(win_opts) then
      return assembler.assemble_statusline(win_opts,
                                           M.statusline.active_special)
   end
   return assembler.assemble_statusline(win_opts, M.statusline.active)
end

local function build_inactive_statusline(win_opts)
   if is_special_buffer(win_opts) then
      return assembler.assemble_statusline(win_opts,
                                           M.statusline.inactive_special)
   end
   return assembler.assemble_statusline(win_opts, M.statusline.inactive)
end

function M.build_statusline(winnr, is_active)
   local win_opts = get_window_opts(winnr)
   reset_mode_highlight()
   local stl = ""
   if is_active then
      stl = build_active_statusline(win_opts)
   else
      stl = build_inactive_statusline(win_opts)
   end
   return stl
end

return M
