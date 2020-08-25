local bolt_components = require("bolt/components")
local bolt_utils = require("bolt/utils")
local M = {}

local function parse_segment_config(win_opts, segment_config)
   local new_component = bolt_components.get_component_by_name(
      win_opts, segment_config.component)
   if new_component == nil or new_component == '' then
      return nil
   end
   local icon = segment_config.icon or ''
   local add_padding = segment_config.add_padding or nil
   local stl = icon .. new_component
   if add_padding then
      stl = ' ' .. stl .. ' '
   end
   local highlight = segment_config.highlight or 'Normal'
   return '%#' .. highlight .. '#' .. stl .. '%0*'
end

local function get_statusline_segment(win_opts, config)
   if config == nil then return '' end
   local segments = {}
   for _, segment_config in ipairs(config) do
      local new_segment = parse_segment_config(win_opts, segment_config)
      if new_segment ~= nil and new_segment ~= '' then
         table.insert(segments, new_segment)
      end
   end
   return bolt_utils.concat_with_padding(segments)
end

function M.assemble_statusline(win_opts, config)
   local left_stl = get_statusline_segment(win_opts, config.left)
   local right_stl = get_statusline_segment(win_opts, config.right)
   return left_stl .. "%=" .. right_stl
end

return M
