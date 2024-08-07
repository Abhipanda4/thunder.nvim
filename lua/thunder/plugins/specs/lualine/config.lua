local lsp_client = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.buf_get_clients(bufnr)
	if next(clients) == nil then
		return ""
	end

	local c = {}
	for _, client in pairs(clients) do
		table.insert(c, client.name)
	end
	return "  " .. table.concat(c, "|")
end

local M = {}

M.get_lualine_config = function()
	local components = require("thunder.plugins.specs.lualine.components")
	local extensions = require("thunder.plugins.specs.lualine.extensions")
	return {
		options = {
			theme = "catppuccin",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = { "filename" },
			lualine_x = {
        "diagnostics",
        lsp_client,
        {"filetype"},
      },
			lualine_y = { components.position },
			lualine_z = {
				{
					components.bar_indicator,
					padding = { left = 0 },
				},
			},
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = { components.position },
			lualine_z = {},
		},
		extensions = {
			"quickfix",
			extensions.get_stl("NvimTree"),
			extensions.get_stl("undotree"),
			extensions.get_stl("dashboard"),
			extensions.get_stl("DiffviewFiles"),
		},
	}
end

return M
