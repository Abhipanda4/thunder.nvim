local M = {
	"mbbill/undotree",
  init = function()
    vim.g.undotree_DiffAutoOpen = 0
    vim.g.undotree_SplitWidth = 40
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_WindowLayout = 3
  end,
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Open UndoTree" } },
	},
}

return M
