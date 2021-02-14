local vim = vim
local windows = require("thunder/utils/windows")

local SEVERITY_MAP = vim.lsp.protocol.DiagnosticSeverity
local SEVERITIES = {"E", "W", "H", "I"}

-- Each diagnostic will contain line break after this width
local MAX_DIAGNOSTIC_WIDTH = 100

-- Max number of lines occupied by all diagnostics
local MAX_TOTAL_HEIGHT = 10

local function get_severity_type(severity)
  local severity_type = SEVERITY_MAP[severity]
  return string.upper(string.sub(severity_type, 1, 1))
end

local function get_highlight_color(severity_type)
  local color_map = {
    E = "LspDiagnosticsPreviewError",
    W = "LspDiagnosticsPreviewWarning",
    I = "LspDiagnosticsPreviewHint",
    H = "LspDiagnosticsPreviewInformation"
  }
  local severity_color = color_map[severity_type]
  if severity_color == nil then
    return color_map.E
  end
  return severity_color
end

local function get_highlight_icon(severity_type)
  local icon_map = {
    E = "",
    W = "",
    I = "",
    H = ""
  }
  local severity_icon = icon_map[severity_type]
  if severity_icon == nil then
    return icon_map.E
  end
  return severity_icon
end

local function get_formatted_diagnostic(severity_type, message)
  local severity_sign = get_highlight_icon(severity_type)
  return string.format(" %s %s", severity_sign, message)
end

local function get_preview_dimensions(contents)
  local max_width = -1
  local num_diagnostics = 0
  for _, severity in ipairs(SEVERITIES) do
    for _, diagnostic in ipairs(contents[severity]) do
      max_width = math.max(max_width, string.len(diagnostic))
      num_diagnostics = num_diagnostics + 1
    end
  end
  return {
    width = math.min(MAX_DIAGNOSTIC_WIDTH, max_width + 5),
    height = math.min(MAX_TOTAL_HEIGHT - 1, num_diagnostics) + 1
  }
end

local function get_display_message(diagnostic_message)
  local message = vim.split(diagnostic_message, "\n", true)[1]
  return message
end

local function get_default_diagnostics_table()
  return {
    E = {},
    W = {},
    I = {},
    H = {}
  }
end

local function trim_diagnostics(diagnostics_tbl)
  local trimmed_diagnostic_tbl = {}
  for _, severity in ipairs(SEVERITIES) do
    trimmed_diagnostic_tbl[severity] = {}
    for _, diagnostic in ipairs(diagnostics_tbl[severity]) do
      local trimmed_diagnostic = string.sub(diagnostic, 1, MAX_DIAGNOSTIC_WIDTH - 10)
      local dots = ""
      if #trimmed_diagnostic < #diagnostic then
        dots = string.rep(".", 3)
      end
      trimmed_diagnostic = string.format("%s%s", trimmed_diagnostic, dots)
      table.insert(trimmed_diagnostic_tbl[severity], trimmed_diagnostic)
    end
  end
  return trimmed_diagnostic_tbl
end

local function insert_diagnostics_in_preview_win(bufnr, diagnostics_tbl)
  local priority_order = {"E", "W", "H", "I"}
  vim.api.nvim_buf_set_lines(bufnr, 0, 0, true, {"   Diagnostics:"})
  local num_lines_added = 1
  for _, severity_type in ipairs(priority_order) do
    if diagnostics_tbl[severity_type] == nil or #diagnostics_tbl[severity_type] == 0 then
      goto continue
    end
    for _, message in ipairs(diagnostics_tbl[severity_type]) do
      local new_msg = get_formatted_diagnostic(severity_type, message)
      vim.api.nvim_buf_set_lines(bufnr, num_lines_added, num_lines_added, true, {new_msg})
      local hl_group = get_highlight_color(severity_type)
      vim.api.nvim_buf_add_highlight(bufnr, -1, hl_group, num_lines_added, 0, 5)
      num_lines_added = num_lines_added + 1
    end
    ::continue::
  end
end

local function inline_diagnostics(opts, bufnr, line_nr, client_id)
  local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
  if vim.tbl_isempty(line_diagnostics) then
    return
  end
  local formatted_diagnostics_tbl = get_default_diagnostics_table()

  -- Collect all diagnostics as per severity type
  for _, diagnostic in ipairs(line_diagnostics) do
    local message = get_display_message(diagnostic.message)
    local severity_type = get_severity_type(diagnostic.severity)
    table.insert(formatted_diagnostics_tbl[severity_type], message)
  end

  -- Shorten extremely long diagnostic messages
  formatted_diagnostics_tbl = trim_diagnostics(formatted_diagnostics_tbl)

  -- Open preview window
  local dimensions = get_preview_dimensions(formatted_diagnostics_tbl)
  local preview_opts = {
    width = dimensions.width,
    height = dimensions.height,
    border_style = "thin"
  }
  local win_opts = windows.make_floating_window_at_cursor(preview_opts)

  -- Populate preview window with highlighted diagnostics
  insert_diagnostics_in_preview_win(win_opts.primary_bufnr, formatted_diagnostics_tbl)

  -- Setup autocmds for autoclosing
  vim.lsp.util.close_preview_autocmd(
    {"CursorMovedI", "BufHidden", "BufLeave", "CursorMoved", "WinScrolled"},
    win_opts.primary_winnr
  )
  vim.lsp.util.close_preview_autocmd(
    {"CursorMovedI", "BufHidden", "BufLeave", "CursorMoved", "WinScrolled"},
    win_opts.border_winnr
  )
end

local function goto_next_diagnostic()
  vim.lsp.diagnostic.goto_next(
    {
      enable_popup = false
    }
  )
end

local function goto_previous_diagnostic()
  vim.lsp.diagnostic.goto_prev(
    {
      enable_popup = false
    }
  )
end

return {
  inline_diagnostics = inline_diagnostics,
  goto_next_diagnostic = goto_next_diagnostic,
  goto_previous_diagnostic = goto_previous_diagnostic
}
