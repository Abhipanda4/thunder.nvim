local M = {}

local function get_nvimtree_indicator()
	return "NvimTree"
end

local nvimtree_config = {
	sections = {
		lualine_a = { get_nvimtree_indicator },
	},
	inactive_sections = {
		lualine_a = { get_nvimtree_indicator },
	},
	filetypes = { "NvimTree" },
}

local function get_undotree_indicator()
	return "UndoTree"
end

local undotree_config = {
	sections = {
		lualine_a = { get_undotree_indicator },
	},
	inactive_sections = {
		lualine_a = { get_undotree_indicator },
	},
	filetypes = { "undotree" },
}

local get_dashboard_indicator = function()
	return "Dashboard"
end

local dashboard_config = {
	sections = {
		lualine_a = { get_dashboard_indicator },
	},
	filetypes = { "dashboard" },
}

local get_diffview_indicator = function()
  return "DiffViewPanel"
end

local diffview_config = {
	sections = {
		lualine_a = { get_diffview_indicator },
	},
	inactive_sections = {
		lualine_a = { get_diffview_indicator },
	},
	filetypes = { "DiffviewFiles" },
}

M.get_stl = function(filetype)
	local config = nil
	if filetype == "NvimTree" then
		config = nvimtree_config
	elseif filetype == "undotree" then
		config = undotree_config
	elseif filetype == "dashboard" then
		config = dashboard_config
	elseif filetype == "DiffviewFiles" then
		config = diffview_config
	end
	return config
end

return M
