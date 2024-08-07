local M = {
  "0x00-ketsu/maximizer.nvim",
  config = true,
  keys = {
    { '<leader>z', '<cmd>lua require("maximizer").toggle() <cr>', desc='Toggle zoom vim window'},
  },
}

return M
