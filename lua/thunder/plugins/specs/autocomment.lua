local M = {
  'numToStr/Comment.nvim',
  opts = {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
        line = 'gc',
        block = 'gb',
    },
    mappings = {
      basic = true,
      extra = false,
    },
  }
}

return M
