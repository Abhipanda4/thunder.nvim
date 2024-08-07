local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Easy jumping to beginning and end of line
keymap("n", "H", "^", opts)
keymap("v", "H", "^", opts)
keymap("n", "L", "g_", opts)
keymap("v", "L", "g_", opts)

-- Follow tradition of C & D
keymap("n", "Y", "y$", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Stay in visual mode after indentation
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- quick replace
keymap("n", "<leader>r", ":%s//g<Left><Left>")

-- declutter
keymap("n", "<leader>o", ":only<cr>", opts)

-- Easy force quit
keymap("n", "<leader>q", ":quit!<cr>", opts)

-- better up/down in case of wrapped lines
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.cmd("command! -nargs=+ -complete=file Grep noautocmd silent grep! <args> | redraw! | copen")
keymap("n", "<leader>g", ":Grep<space>", opts)
