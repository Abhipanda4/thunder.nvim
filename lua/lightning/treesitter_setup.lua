-- ====================================================================
-- Name: lua/treesitter_setup.lua
-- Description: Treesitter for better/faster syntax highlighting
-- Maintainer: Abhisek Panda <abhipanda03@gmail.com>
-- ====================================================================


local ts_config = require'nvim-treesitter.configs'
local M = {}

function M.setup_treesitter()
    ts_config.setup {
        highlight = {
            enable = true,       -- false will disable the whole extension
            disable = {},        -- list of language that will be disabled
        },
        incremental_selection = {
            enable = true,
            disable = {},
            keymaps = {}
        },
        -- List of languages whose parsers should be installed automatically
        ensure_installed = {'python', 'cpp', 'lua', 'json'}
    }
end

return M
