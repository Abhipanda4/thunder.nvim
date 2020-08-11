local vim = vim
local sparx_engine = require('sparx/lib/engine')
local sparx_render = require('sparx/lib/render')
local sparx_utils = require('sparx/lib/utils')
local FS_ACTIONS = {
   edit              = false,
   recursive_expand  = false,
   vsplit            = false,
   split             = false,
   create            = true,
   rename            = true,
   delete            = true,
}
local M = {}

M.viewport = {
   cwd = nil,
   is_loaded = false,
   buf_handle = nil,
   win_handle = nil,
   filesystem_structure = nil,
   tree_view = nil,
}

local function is_inside_sparx_window()
   local curr_win = vim.api.nvim_get_current_win()
   if curr_win == M.viewport.win_handle then return true end
   return false
end

local function init()
   local buf_handle = sparx_utils.create_buffer()
   local win_handle = sparx_utils.create_window()
   vim.api.nvim_win_set_buf(win_handle, buf_handle)
   vim.api.nvim_command('doautocmd BufEnter,WinEnter')
   M.viewport.cwd = vim.loop.cwd()
   M.viewport.is_loaded = true
   M.viewport.buf_handle = buf_handle
   M.viewport.win_handle = win_handle
   if M.viewport.filesystem_structure == nil then
      sparx_engine.initialize_first_level(M.viewport)
   end
   sparx_engine.set_mappings(buf_handle)
end

function M.get_win_handle()
   return M.viewport.win_handle
end

function M.get_buf_handle()
   return M.viewport.buf_handle
end

function M.open_tree_view()
   init()
   sparx_render.draw_tree(M.viewport)
end

function M.expand_till_filepath(filepath)
   local next_expand_node = nil
   local nodes_in_current_scope = M.viewport.filesystem_structure.root.children
   for _, subdirectory in ipairs(sparx_utils.get_all_dirs_in_path(filepath)) do
      next_expand_node = nodes_in_current_scope[subdirectory]
      sparx_engine.expand_node(next_expand_node)
      nodes_in_current_scope = next_expand_node.children
   end
   sparx_render.draw_tree(M.viewport)
end

function M.close_tree_view()
   if vim.api.nvim_win_is_valid(M.viewport.win_handle) then
      if #vim.api.nvim_list_wins() == 1 then
         vim.api.nvim_command(':quit!')
      end
      if is_inside_sparx_window() then
         vim.api.nvim_command('wincmd p')
      end
      vim.api.nvim_win_close(M.viewport.win_handle, true)
   end
   M.viewport.buf_handle = nil
   M.viewport.win_handle = nil
end

function M.is_window_initialized()
   return M.viewport.win_handle ~= nil
end

function M.register_event(action)
   local current_node = sparx_engine.get_node_at_cursor(M.viewport)
   M.handle_event(action, current_node)
end

function M.refresh_tree()
   M.viewport.filesystem_structure.root = sparx_engine.replicate_tree_recursively(
      M.viewport.filesystem_structure.root)
end

-- =========================================
-- Functions to handle filesystem operations
-- =========================================

local function is_fs_action(action)
   if FS_ACTIONS[action] == nil then
      print('Unrecognized action: ' .. action)
   end
   return FS_ACTIONS[action]
end

local function clear_prompt()
   vim.api.nvim_command('normal :esc<cr>')
end

local function clear_buffer(absolute_path)
  for _, buf in pairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_name(buf) == absolute_path then
      vim.api.nvim_command(':bd! '..buf)
    end
  end
end

local function create_file(filepath)
   vim.loop.fs_open(filepath, "w", 420, vim.schedule_wrap(function(err, fd)
      if err then
         vim.api.nvim_err_writeln('Could not create file ' .. filepath)
      else
         vim.loop.fs_close(fd)
         vim.api.nvim_out_write(string.format(
            'File %s was successfully created', filepath))
      end
      M.refresh_tree()
      sparx_render.draw_tree(M.viewport)
  end))
end

local function create_node(node)
   local path_under_cursor = node.absolute_path
   if node.nodetype == 'directory' then
      path_under_cursor = path_under_cursor .. '/'
   end
   local new_file = vim.fn.input({
      ['prompt'] = 'Create new file: ',
      ['default'] = path_under_cursor:gsub('/[^/]*$', '/'),
      ['completion'] = 'file',
   })
   clear_prompt()
   new_file = new_file:gsub(M.viewport.cwd .. '/', '')
   local relpath = M.viewport.cwd .. '/'
   for subpath in new_file:gmatch('[^/]+/?') do
      relpath = relpath .. subpath
      if relpath:match('.*/$') then
         -- If path is ending in '/', create a folder
         _ = vim.loop.fs_mkdir(relpath, 493)
      else
         -- If path does not end with '/', create an empty file
         create_file(relpath)
      end
   end
   if new_file:match('.*/$') then
      M.refresh_tree()
      sparx_render.draw_tree(M.viewport)
   end
end

local function rename_file(node)
   local curr_file = node.absolute_path:gsub(M.viewport.cwd .. '/', '')
   local new_file = vim.fn.input({
      ['prompt'] = 'Rename ' .. curr_file .. ' ➜ ',
      ['default'] = curr_file,
      ['completion'] = 'file',
   })
   clear_prompt()
   new_file = M.viewport.cwd .. '/' .. new_file
   local success = vim.loop.fs_rename(node.absolute_path, new_file)
   if not success then
      vim.api.nvim_err_writeln(
         'Could not rename ' .. node.absolute_path .. ' to ' .. new_file)
      return
   end
   for _, buf in pairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_get_name(buf) == node.absolute_path then
         vim.api.nvim_buf_set_name(buf, new_file)
      end
   end
   M.refresh_tree()
   sparx_render.draw_tree(M.viewport)
end

local function copy_file(node)
   print('Not implemented')
end

local function delete_node(node)
   local curr_path = node.absolute_path:gsub(vim.fn.environ()['HOME'], '~')
   local confirm_delete = vim.fn.input({
      ['prompt'] = 'Remove ' .. curr_path .. ' ? (y|n): '
   })
   clear_prompt()
   if confirm_delete:match('^y') then
      if node.nodetype == 'directory' then
         -- TODO: implement remove dir safely
         print('Directory: ' .. node.absolute_path .. ' NOT removed')
      else
         local success = vim.loop.fs_unlink(node.absolute_path)
         if not success then
            vim.api.nvim_err_writeln('Could not remove '..node.name)
         end
      end
      vim.api.nvim_out_write(node.name..' removed successfully!\n')
      clear_buffer(node.absolute_path)
      M.refresh_tree()
      sparx_render.draw_tree(M.viewport)
   end
end

local function handle_fs_event(action, node)
   if action == 'create' then
      create_node(node)
   elseif action == 'rename' then
      rename_file(node)
   elseif action == 'copy' then
      copy_file(node)
   elseif action == 'delete' then
      delete_node(node)
   end
end

local function handle_directory_event(action, node)
   if action == 'edit' then
      sparx_engine.expand_node(node, true)
   elseif action == 'recursive_expand' then
      sparx_engine.expand_all_nodes(node)
   else
      vim.api.nvim_err_writeln(string.format(
         'Invalid operation [%s] on directory %s', action, node.name))
   end
   sparx_render.draw_tree(M.viewport)
end

local function handle_file_event(action, node)
   vim.api.nvim_command('noautocmd wincmd p')
   vim.api.nvim_command(string.format("%s %s", action, node.absolute_path))
end

function M.handle_event(action, node)
   if node == nil then return end
   if is_fs_action(action) then
      handle_fs_event(action, node)
   elseif node.nodetype == 'directory' then
      handle_directory_event(action, node)
   elseif node.nodetype == 'file' then
      handle_file_event(action, node)
   end
end

return M
