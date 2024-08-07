local M = {
  {
    'ten3roberts/qf.nvim',
    opts = {
      l = {
        auto_close = true,
        auto_follow = false,
        auto_open = true,
        auto_resize = true,
        max_height = 10,
        min_height = 8,
        wide = true,
        number = true,
        relativenumber = false,
        unfocus_close = false,
        focus_open = false,
      },
      c = {
        auto_close = true,
        auto_follow = false,
        auto_open = true,
        auto_resize = true,
        max_height = 10,
        min_height = 8,
        wide = true,
        number = true,
        relativenumber = false,
        unfocus_close = false,
        focus_open = false,
      },
      close_other = false,
      pretty = false,
      silent = true,
    },
    keys = {
      -- Quickfix mappings
      {
        ']q',
        '<cmd>lua require("qf").below("c") <CR>',
        desc='Go to next entry from cursor'
      },
      {
        '[q',
        '<cmd>lua require("qf").above("c") <CR>',
        desc='Go to previous entry from cursor'
      },
      {
        'gq',
        "<cmd>lua require'qf'.toggle('c', false) <cr>",
        desc='Toggle quickfix list'
      },

      -- Loclist mappings
      {
        ']l',
        '<cmd>lua require("qf").below("l") <CR>',
        desc='Go to next entry from cursor'
      },
      {
        '[l',
        '<cmd>lua require("qf").above("l") <CR>',
        desc='Go to previous entry from cursor'
      },
      {
        'gl',
        "<cmd>lua require'qf'.toggle('l', false) <cr>",
        desc='Toggle location list'
      },

    },
  },
}

return M
