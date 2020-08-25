local vim = vim
local M = {}
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

function M.get_current_mode()
   return MODE_MAP[vim.fn.mode()]
end

function M.concat_with_padding(display_strings, separator)
   if display_strings == nil or #display_strings == 0 then
      return ''
   end
   if separator == nil then
      separator = ' '
   end
   local non_empty_strings = vim.fn.filter(display_strings, 'v:val != ""')
   return vim.fn.join(non_empty_strings, separator)
end

return M
