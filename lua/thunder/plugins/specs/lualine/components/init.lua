local M = {}

M.lsp_progress = function()
end

M.treesitter_info = function()
end

M.lsp_info = function()
end

M.bar_indicator = function()
    return ' '
end

M.position = function()
	local line = vim.fn.line(".")
	local col = vim.fn.virtcol(".")
	local total = vim.fn.line("$")
	return string.format("%2d:%3d/%d", col, line, total)
end

return M
