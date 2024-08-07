local M = {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		init = function()
			local colors = require("catppuccin.palettes").get_palette("mocha")
			vim.api.nvim_set_hl(0, "DashboardMruTitle", { fg = colors.green })
			vim.api.nvim_set_hl(0, "DashboardHeader", { fg = colors.blue })
		end,
		config = function()
			local header = {
				"",
				" _   _                     _                          _           ",
				"| | | |                   | |                        (_)          ",
				"| |_| |__  _   _ _ __   __| | ___ _ __     _ ____   ___ _ __ ___  ",
				"| __| '_ \\| | | | '_ \\ / _` |/ _ \\ '__|   | '_ \\ \\ / / | '_ ` _ \\ ",
				"| |_| | | | |_| | | | | (_| |  __/ |     _| | | \\ V /| | | | | | |",
				" \\__|_| |_|\\__,_|_| |_|\\__,_|\\___|_|    (_)_| |_|\\_/ |_|_| |_| |_|",
				"                                                                  ",
				"                                                                  ",
			}
			require("dashboard").setup({
				theme = "hyper",
				disable_move = true,
				shortcut_type = "number",
				change_to_vcs_root = true,
				config = {
					header = header,
					shortcut = {
						{
							desc = "󰈞 Find Files",
							group = "Keyword",
							key = "f",
							action = "<cmd>lua require('fzf-lua').files({ resume = false, header=false }) <cr>",
						},
						{
							desc = "󰈬 Find Symbols",
							group = "Keyword",
							key = "s",
							action = "<cmd>lua require('fzf-lua').files({ resume = false, header=false }) <cr>",
						},
					},
					packages = { enable = true },
					project = { enable = false },
					mru = {
						limit = 9,
						label = "MRU Files",
						cwd_only = true,
					},
					footer = {},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}

return M
