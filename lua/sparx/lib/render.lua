local sparx_icons = require("sparx/lib/icons")
local vim = vim
local INDENT_SIZE = 3
local M = {}

local function decide_display_props(node)
   -- display = padding + icon + name
   -- padding is decide on basis of level
   -- icon is decided on nodetype(dir/symlink) and filetype for files
   local start_pos = INDENT_SIZE * node.level
   local left_padding = string.rep(" ", start_pos)
   local icon = sparx_icons.get_icon_for_node(node)
   local name = left_padding .. icon .. " " .. node.name
   return {
      name = name,
      start_column = start_pos,
      icon_hi_group = sparx_icons.get_icon_color(node),
      name_hi_group = sparx_icons.get_file_color(node),
   }
end

local function setup_header(_)
   return { '' }
end

local function get_fixed_order_tree(nodes)
   local ordered_nodes = {}
   local idx = 1
   for _, node in pairs(nodes) do
      if node.nodetype == 'directory' then
         ordered_nodes[idx] = node
         idx = idx + 1
      end
   end
   for _, node in pairs(nodes) do
      if node.nodetype == 'file' then
         ordered_nodes[idx] = node
         idx = idx + 1
      end
   end
   for _, node in pairs(nodes) do
      if node.nodetype == 'link' then
         ordered_nodes[idx] = node
         idx = idx + 1
      end
   end
   return ordered_nodes
end

local function collect_nodes_recursiveley(top_level_nodes, tracker)
   local ordered_nodes = get_fixed_order_tree(top_level_nodes)
   for _, node in pairs(ordered_nodes) do
      -- Add current node to display
      tracker.tree[tracker.start_index] = node
      tracker.start_index = tracker.start_index + 1

      -- Then add all its descendants recursively
      if node.is_open and node.children ~= nil then
         collect_nodes_recursiveley(node.children, tracker)
      end
   end
end

local function write_names_to_buffer(buffer_id, display_lines)
   -- Set filenames in tree viewing buffer
   vim.api.nvim_buf_set_lines(
      buffer_id,
      0,
      -1,
      false,
      display_lines
   )
end

local function highlight_names(buffer_id, color_props)
   for _, color_prop in ipairs(color_props) do
      vim.api.nvim_buf_add_highlight(
         buffer_id,
         -1,
         color_prop.icon_hi_group,
         color_prop.line,
         color_prop.start_column,
         color_prop.start_column + 4
      )
      vim.api.nvim_buf_add_highlight(
         buffer_id,
         -1,
         color_prop.name_hi_group,
         color_prop.line,
         color_prop.start_column + 4,
         -1
      )
   end
end

function M.draw_tree(viewport)
   vim.api.nvim_buf_set_option(viewport.buf_handle, 'modifiable', true)
   local orig_cursor_position = vim.api.nvim_win_get_cursor(viewport.win_handle)

   local color_props = {}
   local display_lines = setup_header(viewport)
   local display_tracker = {
      ['tree'] = {},
      ['start_index'] = #display_lines + 1,
   }
   collect_nodes_recursiveley(viewport.filesystem_structure, display_tracker)
   viewport.display_tree = display_tracker.tree
   for idx, node in pairs(viewport.display_tree) do
      local display_props = decide_display_props(node)
      table.insert(display_lines, display_props.name)
      table.insert(color_props, {
         line = idx - 1,
         start_column = display_props.start_column,
         icon_hi_group = display_props.icon_hi_group,
         name_hi_group = display_props.name_hi_group,
      })
   end

   write_names_to_buffer(viewport.buf_handle, display_lines)
   highlight_names(viewport.buf_handle, color_props)

   vim.api.nvim_win_set_cursor(viewport.win_handle, orig_cursor_position)
   vim.api.nvim_buf_set_option(viewport.buf_handle, 'modifiable', false)
end

return M
