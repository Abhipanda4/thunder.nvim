local vim = vim

local SUPPORTED_BORDERS = {
   ["thin"] = {
      top_left = "┌",
      mid_horizontal = "─",
      top_right = "┐",
      mid_vertical = "│",
      bottom_left = "└",
      bottom_right = "┘"
   },
   ["doubleline"] = {
      top_left = "╔",
      mid_horizontal = "═",
      top_right = "╗",
      mid_vertical = "║",
      bottom_left = "╚",
      bottom_right = "╝"
   },
   ["rounded"] = {
      top_left = "╭",
      mid_horizontal = "─",
      top_right = "╮",
      mid_vertical = "│",
      bottom_left = "╰",
      bottom_right = "╯"
   },
   ["thick"] = {
      top_left = "┏",
      mid_horizontal = "━",
      top_right = "┓",
      mid_vertical = "┃",
      bottom_left = "┗",
      bottom_right = "┛"
   }
}

local function get_border_design(border_style)
   return SUPPORTED_BORDERS[border_style]
end

-- @param border_opts Table with all essential chars for filling border
-- @param border_opts {width, height} for the border window
-- @returns Table with contents for the border window
local function get_border_window_contents(border_style, border_opts)
   local border_design = get_border_design(border_style)
   if border_design == nil then
      return nil
   end
   local border_win_contents = {}
   local horizontal_border = string.rep(border_design.mid_horizontal, border_opts.width - 2)
   table.insert(border_win_contents, border_design.top_left .. horizontal_border .. border_design.top_right)
   local middle_line = border_design.mid_vertical .. string.rep(" ", border_opts.width - 2) .. border_design.mid_vertical
   for _ = 1, border_opts.height - 2 do
      table.insert(border_win_contents, middle_line)
   end
   table.insert(border_win_contents, border_design.bottom_left .. horizontal_border .. border_design.bottom_right)
   return border_win_contents
end

local function get_border_opts(primary_win_opts)
   local border_opts = vim.deepcopy(primary_win_opts)
   border_opts.width = primary_win_opts.width + 2
   border_opts.height = primary_win_opts.height + 2
   border_opts.row = primary_win_opts.row - 1
   border_opts.col = primary_win_opts.col - 1
   return border_opts
end

local function setup_autocmd(primary_bufnr, border_winnr)
   vim.api.nvim_command(
   string.format(
   "autocmd WinLeave,BufLeave,BufDelete <buffer=%s> ++once ++nested silent! call nvim_win_close(%s, v:true)",
   primary_bufnr,
   border_winnr
   )
   )
end

local function create_floating_window(window_opts, content, enter)
   local bufnr = vim.api.nvim_create_buf(false, true)
   vim.api.nvim_buf_set_option(bufnr, "bufhidden", "wipe")
   local winnr = vim.api.nvim_open_win(bufnr, enter, window_opts)
   if content ~= nil then
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
   end
   return winnr, bufnr
end

local function apply_highlight(bufnr, hl_group)
   local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)
   for i=0,#lines,1 do
      vim.api.nvim_buf_add_highlight(bufnr, -1, 'LspDiagnosticsBorder', i, 0, -1)
   end
end

local function make_centered_floating_window(opts)
   opts = opts or {}
   local nvim_width = vim.api.nvim_get_option("columns")
   local nvim_height = vim.api.nvim_get_option("lines")
   local width = opts.width or math.ceil(nvim_width * 0.5)
   local height = opts.height or math.ceil(nvim_height * 0.5)

   local primary_win_opts = {
      style = "minimal",
      relative = "editor",
      width = width,
      height = height,
      row = math.ceil((nvim_height - height) * 0.5 - 1),
      col = math.ceil((nvim_width - width) * 0.5 - 1)
   }
   local border_opts = get_border_opts(primary_win_opts)
   local border_style = opts.border_style or "doubleline"
   local border_content = get_border_window_contents(border_style, border_opts)
   local border_winnr, border_bufnr = create_floating_window(border_opts, border_content, true)
   local primary_winnr, primary_bufnr = create_floating_window(primary_win_opts, nil, true)

   local hl_color = string.format("NormalFloat:%s", opts.highlight_group or "NormalFloat")
   vim.api.nvim_win_set_option(border_winnr, "winhl", hl_color)
   vim.api.nvim_win_set_option(primary_winnr, "winhl", hl_color)
   setup_autocmd(primary_bufnr, border_winnr)
   return {
      primary_winnr = primary_winnr,
      primary_bufnr = primary_bufnr,
      border_winnr = border_winnr,
      border_bufnr = border_bufnr
   }
end

local function get_preview_position_in_viewport()
   return {
      row = 2,
      col = 1
   }
end

local function make_floating_window_at_cursor(opts)
   opts = opts or {}
   local preview_position = get_preview_position_in_viewport()
   local primary_win_opts = {
      style = "minimal",
      relative = "cursor",
      width = opts.width,
      height = opts.height,
      row = preview_position.row,
      col = preview_position.col
   }
   local border_opts = get_border_opts(primary_win_opts)
   local border_style = opts.border_style or "doubleline"
   local border_content = get_border_window_contents(border_style, border_opts)
   local primary_winnr, primary_bufnr = create_floating_window(primary_win_opts, nil, false)
   local border_winnr, border_bufnr = create_floating_window(border_opts, border_content, false)
   -- apply_highlight(border_bufnr, opts.border_highlight)

   local hl_color = string.format("NormalFloat:%s", opts.highlight_group or "Normal")
   vim.api.nvim_win_set_option(border_winnr, "winhl", hl_color)
   vim.api.nvim_win_set_option(primary_winnr, "winhl", hl_color)
   return {
      primary_winnr = primary_winnr,
      primary_bufnr = primary_bufnr,
      border_winnr = border_winnr,
      border_bufnr = border_bufnr
   }
end

return {
   make_floating_window_at_cursor = make_floating_window_at_cursor,
   make_centered_floating_window = make_centered_floating_window
}
