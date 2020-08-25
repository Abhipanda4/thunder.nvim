local vim = vim
local lspconfig = require('lspconfig')
local lsp_handlers = require('lsp/handlers')
local lsp_bindings = require('lsp/bindings')
local lsp_autocmds = require('lsp/autocmds')
local M = {}

local function on_attach_handler(_, bufnr)
   -- Use LSP as the handler for omnifunc.
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

   -- Overwrite default settings for some requests
   lsp_handlers.setup()

   -- Set custom keybings for LSP actions
   lsp_bindings.setup()

   -- Setup autocmd for LSP related actions
   lsp_autocmds.setup()
end

local function setup_lsp_for_python()
   lspconfig['pyls'].setup {
      on_attach = on_attach_handler,
      settings = {
         pyls = {
            plugins = {
               pycodestyle = {
                  enabled = false
               },
               pydocstyle = {
                  enabled = false,
               },
               pylint = {
                  enabled = true
               }
            }
         }
      }
   }
end

local function setup_lsp_for_vim()
   lspconfig['vimls'].setup {
      on_attach = on_attach_handler
   }
end

local function setup_lsp_for_lua()
   lspconfig['sumneko_lua'].setup {
      -- TODO: use env variables
      cmd = {
         '/Users/abhipanda/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/macOS/lua-language-server',
         '-E',
         '/Users/abhipanda/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua'
      },
      settings = {
         Lua = {
            runtime = {
               version = "LuaJIT",
               path = vim.split(package.path, ';'),
            },
            diagnostics = {
               enable = true,
               globals = { "vim" },
            },
            workspace = {
               library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
               }
            }
         }
      },
      on_attach = on_attach_handler
   }
end

local lsp_setups = {
   ['python'] = setup_lsp_for_python,
   ['lua'] = setup_lsp_for_lua,
   ['vim'] = setup_lsp_for_vim,
}

function M.setup()
   for _, lsp_setup_function in pairs(lsp_setups) do
      lsp_setup_function()
   end
end

return M
