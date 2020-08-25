local vim = vim

local function setup()
   vim.api.nvim_command([[
      autocmd CursorHold <buffer> lua require("lsp/diagnostics").inline_diagnostics()
   ]])
end

return {
   setup = setup
}
