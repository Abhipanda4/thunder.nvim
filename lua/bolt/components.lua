local vim = vim
local M = {}

function M.mode_component()
   return "Mode"
end

function M.filename_component()
   return "Filename"
end

function M.readonly_component()
   return 'RO'
end

function M.modified_component()
   return '+'
end

function M.diagnostics_component()
   return 'Diagnostics'
end

function M.filetype_component()
   return 'Filetype'
end

function M.lineinfo_component()
   return 'Lines'
end

return M
