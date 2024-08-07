local M = {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false,
	},
	keys = {
		{ "<leader>t", "<cmd>TodoQuickFix<cr>", desc = "show all todos in quickfix" },
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Jump to next TODO item",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Jump to prev TODO item",
		},
	},
}

return M
