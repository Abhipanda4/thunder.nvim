local M = {
  {
    "yorickpeterse/nvim-pqf",
    opts = {
      signs = {
        error = { text = ' ', hl = 'DiagnosticSignError' },
        warning = { text = ' ', hl = 'DiagnosticSignWarn' },
        info = { text = ' ', hl = 'DiagnosticSignInfo' },
        hint = { text = ' ', hl = 'DiagnosticSignHint' },
      },
      show_multiple_lines = false,
      max_filename_length = 60,
      filename_truncate_prefix = '[...]',
    },
  },
}

return M
