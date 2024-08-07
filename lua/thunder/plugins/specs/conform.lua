local M = {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			go = { "goimports", "gofmt", "golines" },
		},
		format_on_save = nil,
	},
	keys = {
		{
			"<leader>=",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
	init = function()
		vim.o.formatexpr = 'v:lua.require("conform").formatexpr()'
	end,
}

return M
