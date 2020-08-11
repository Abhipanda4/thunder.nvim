local sparx_config = require('sparx/lib/config')
local vim = vim
local M = {}
local IGNORE_FILES = vim.split(vim.api.nvim_get_option('wildignore'), ',')

local function should_ignore(path)
   for _, pattern in ipairs(IGNORE_FILES) do
      if string.match(path, pattern) then
         return true
      end
   end
   return false
end

local function listdir(root_dir, level)
   local handle = vim.loop.fs_scandir(root_dir)
   if type(handle) == 'string' then
      vim.api.nvim_err_writeln(handle)
      return
   end

   -- TODO: can be refactored since ordering does not matter here
   local dirs = {}
   local links = {}
   local files = {}
   while true do
      local name, t = vim.loop.fs_scandir_next(handle)
      if not name then break end
      if should_ignore(name) then goto continue end
      if t == 'directory' then
         table.insert(dirs, name)
      elseif t == 'file' then
         table.insert(files, name)
      elseif t == 'link' then
         table.insert(links, name)
      end
      ::continue::
   end

   local entries = {}
   for _, dirname in ipairs(dirs) do
      entries[dirname] = M.create_new_node(root_dir, dirname, 'directory', level)
   end
   for _, linkname in ipairs(links) do
      entries[linkname] = M.create_new_node(root_dir, linkname, 'link', level)
   end
   for _, filename in ipairs(files) do
      entries[filename] = M.create_new_node(root_dir, filename, 'file', level)
   end
   return entries
end

function M.create_new_node(root_dir, name, nodetype, level)
   local absolute_path = nil
   if root_dir == nil then
      absolute_path = name:gsub('~', vim.fn.environ()['HOME'])
   else
      absolute_path = root_dir .. '/' .. name
   end
   return {
      root_dir = root_dir,
      name = name,
      nodetype = nodetype,
      level = level,
      absolute_path = absolute_path,
      is_open = false,
      children = nil,
   }
end

function M.initialize_first_level(viewport)
   local root_node = M.create_new_node(nil, viewport.cwd,
                                       'directory', 0)
   M.expand_node(root_node, false)
   root_node.name = root_node.name:gsub(vim.fn.environ()['HOME'], '~')
   viewport.filesystem_structure = {
      ['root'] = root_node
   }
end

function M.set_mappings(buffer)
   local mappings = sparx_config.get_mappings()
   local actions = {
      [mappings.edit] = 'register_event("edit")',
      [mappings.recursive_expand] = 'register_event("recursive_expand")',
      [mappings.vsplit] = 'register_event("vsplit")',
      [mappings.split] = 'register_event("split")',
      [mappings.create] = 'register_event("create")',
      [mappings.copy] = 'register_event("copy")',
      [mappings.rename] = 'register_event("rename")',
      [mappings.delete] = 'register_event("delete")',
   }

   for keymap, function_call in pairs(actions) do
      vim.api.nvim_buf_set_keymap(
         buffer,
         'n',
         keymap,
         ':lua require("sparx/lib/controller").' .. function_call .. '<CR>',
         {
            nowait = true, noremap = true, silent = true
         }
      )
   end
end

function M.get_node_at_cursor(viewport)
   local current_line = vim.api.nvim_win_get_cursor(viewport.win_handle)[1]
   return viewport.display_tree[current_line]
end

function M.replicate_tree_recursively(node)
   if node == nil then return nil end
   local new_node = M.create_new_node(node.root_dir, node.name,
                                      node.nodetype, node.level)
   if node.is_open then
      new_node.children = {}
      local old_children = node.children
      local new_children = listdir(node.absolute_path, node.level + 1)
      for name, child in pairs(new_children) do
         if child.nodetype ~= 'directory' then
            new_node.children[name] = child
            goto continue
         end
         local old_child = old_children[name]
         if old_child == nil then
            new_node.children[name] = child
         else
            new_node.children[name] = M.replicate_tree_recursively(old_child)
         end

         ::continue::
      end
      new_node.is_open = true
   end
   return new_node
end

function M.expand_node(node, should_toggle)
   if not node.children then
      node.children = listdir(node.absolute_path, node.level + 1)
   end
   if should_toggle then
      node.is_open = not node.is_open
   else
      node.is_open = true
   end
end

function M.expand_all_nodes(node)
   if node.nodetype ~= 'directory' then return end
   M.expand_node(node, false)
   for _, child in pairs(node.children) do
      M.expand_all_nodes(child)
   end
end

return M
