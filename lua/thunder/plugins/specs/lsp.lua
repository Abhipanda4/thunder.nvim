local M = {
	"junnplus/lsp-setup.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"dnlhc/glance.nvim",
	},
	init = function()
		local colors = require("catppuccin.palettes").get_palette("mocha")
		vim.api.nvim_set_hl(0, "GlanceWinBarTitle", { fg = colors.maroon })
		vim.api.nvim_set_hl(0, "GlanceWinBarFilename", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "GlanceFoldIcon", { fg = colors.maroon })
	end,
	config = function()
		local lsp_setup = require("lsp-setup")
		-- Setup glance: Better ui for lsp references/definitions/implementations
		require("glance").setup({
			border = {
				enable = true,
			},
			list = {
				position = "left",
				width = 0.40,
			},
			theme = {
				mode = "darken",
			},
		})

		require("thunder.plugins.specs.lsp_utils.diagnostics").setup()
		require("thunder.plugins.specs.lsp_utils.handlers").setup()

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		lsp_setup.setup({
			mappings = {
				["K"] = "<cmd>lua vim.lsp.buf.hover()<cr>",
				["gr"] = "<cmd>Glance references<cr>",
				["gd"] = "<cmd>Glance definitions<cr>",
				["gi"] = "<cmd>Glance implementations<cr>",
				["g/"] = "<cmd>lua vim.lsp.buf.rename()<cr>",
			},
			servers = {
				["pyright"] = {
					capabilities = capabilities,
				},
				["gopls"] = {
					capabilities = capabilities,
					analyses = {
						assign = true,
						atomic = true,
						bools = true,
						composites = true,
						copylocks = true,
						deepequalerrors = true,
						embed = true,
						errorsas = true,
						fieldalignment = true,
						httpresponse = true,
						ifaceassert = true,
						loopclosure = true,
						lostcancel = true,
						nilfunc = true,
						nilness = true,
						nonewvars = true,
						printf = true,
						shadow = true,
						shift = true,
						simplifycompositelit = true,
						simplifyrange = true,
						simplifyslice = true,
						sortslice = true,
						stdmethods = true,
						stringintconv = true,
						structtag = true,
						testinggoroutine = true,
						tests = true,
						timeformat = true,
						unmarshal = true,
						unreachable = true,
						unsafeptr = true,
						unusedparams = true,
						unusedresult = true,
						unusedvariable = true,
						unusedwrite = true,
						useany = true,
					},
					hoverKind = "FullDocumentation",
					usePlaceholders = true,
					vulncheck = "Imports",
				},
				["lua_ls"] = {
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = true,
							},
						},
					},
				},
			},
			on_attach = function(a1, a2)
				-- leave empty for now
			end,
		})
	end,
}

return M
