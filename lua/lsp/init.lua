-- ====================================================================
-- Name:        lua/lsp_setup.lua
-- Description: Language Server Protocal related settings
-- Maintainer:  Abhisek Panda <abhipanda03@gmail.com>
-- ====================================================================

local vim = vim
local nvim_lsp = require("nvim_lsp")
local diagnostics = require("lsp/diagnostics")
local M = {}

local function on_attach_handler(_, bufnr)
   diagnostics.setup()
   vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
   vim.api.nvim_command("nnoremap , :lua require'lsp/hover_diagnostics'.show_diagnostics_in_hover()<cr>")
end

local function setup_lsp_for_python()
   nvim_lsp['pyls'].setup {
      on_attach = on_attach_handler,
   }
end

local function setup_lsp_for_vim()
   nvim_lsp['vimls'].setup {
      on_attach = on_attach_handler
   }
end

local function setup_lsp_for_lua()
   nvim_lsp['sumneko_lua'].setup {
      cmd = {
         "/Users/abhipanda/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/macOS/lua-language-server",
         "-E",
         "/Users/abhipanda/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
      },
      on_attach = on_attach_handler
   }
end

function M.setup_lsp()
   setup_lsp_for_python()
   setup_lsp_for_vim()
   setup_lsp_for_lua()
end

return M
