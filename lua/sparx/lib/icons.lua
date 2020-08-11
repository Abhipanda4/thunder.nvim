local vim = vim
local DEFAULT_FILE_ICON = ""
local FILETYPE_ICONS = {
   ["py"] = "",
   ["vim"] = "",
   ["json"] = "",
   ["lua"] = "",
   ["cpp"] = "",
   ["zsh"] = "",
   ["sh"] = "",
   ["md"] = "",
}
local M = {}

local function get_dir_symbol(is_open)
   if is_open then return "" end
   return ""
end

local function get_symlink_symbol()
   return "S"
end

local function get_filetype_symbol(filename)
   local splits = vim.split(filename, '.', true)
   local filetype = splits[#splits]
   local icon = FILETYPE_ICONS[filetype]
   if icon == nil then return DEFAULT_FILE_ICON end
   return icon
end

function M.get_icon_for_node(node)
   if node.nodetype == 'directory' then return get_dir_symbol(node.is_open) end
   if node.nodetype == 'symlink' then return get_symlink_symbol() end
   if node.nodetype == 'file' then return get_filetype_symbol(node.name) end
   return DEFAULT_FILE_ICON
end

function M.get_icon_color(node)
   if node.nodetype == 'directory' then
      return 'SparxDirectoryIcon'
   elseif node.nodetype == 'file' then
      return 'SparxFileIcon'
   elseif node.nodetype == 'symlink' then
      return 'SparxLinkIcon'
   end
end

function M.get_file_color(node)
   if node.nodetype == 'directory' then
      return 'SparxDirectory'
   elseif node.nodetype == 'file' then
      return 'SparxFile'
   elseif node.nodetype == 'symlink' then
      return 'SparxLink'
   end
end

return M
