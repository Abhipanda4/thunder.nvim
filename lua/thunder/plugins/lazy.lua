local M = {}
M.setup = function()
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"--single-branch",
			"https://github.com/folke/lazy.nvim.git",
			lazypath,
		})
	end
	vim.opt.runtimepath:prepend(lazypath)

	-- use a protected call so we don't error out on first use
	local status_ok, _ = pcall(require, "lazy")
	if not status_ok then
		print("Lazy just installed, please restart neovim")
		return
	end

	require("lazy").setup("thunder.plugins.specs", {
		install = {
			-- install missing plugins on startup.
			missing = true,
			-- try to load one of these colorschemes when starting an installation during startup
			colorscheme = { "catppuccin" },
		},
		ui = {
			size = { width = 0.7, height = 0.7 },
			wrap = true,
			border = "double",
			title = "Lazy.nvim",
			custom_keys = nil,
		},
		change_detection = {
			enabled = false,
			notify = false,
		},
		performance = {
			cache = {
				enabled = true,
			},
			reset_packpath = true,
			rtp = {
				disabled_plugins = {
					"gzip",
					"matchparen",
					"netrwPlugin",
					"tarPlugin",
					"tohtml",
					"tutor",
					"zipPlugin",
				},
			},
		},
	})
end

return M
