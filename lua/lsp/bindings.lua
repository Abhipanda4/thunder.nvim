local vim = vim

-- Force reload - :lua vim.lsp.stop_client(vim.lsp.get_active_clients()) | edit

local function set_buf_keymap(mode, lhs, rhs, opts)
   vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
end

local function setup()
   local map_opts = {
      noremap = true,
      silent = true,
   }
   set_buf_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
   set_buf_keymap('n', 'K', '<cmd>lua require("lsp/hover").fancy_preview()<CR>', map_opts)

   -- TODO: Figure out usecase in current workflow
   set_buf_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
   set_buf_keymap('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)

   -- Navigate between diagnostics
   set_buf_keymap('n', '[d', '<cmd>lua require("lsp/diagnostics").goto_previous_diagnostic()<CR>', map_opts)
   set_buf_keymap('n', ']d', '<cmd>lua require("lsp/diagnostics").goto_next_diagnostic()<CR>', map_opts)
end

return {
   setup = setup,
}
