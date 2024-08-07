local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


local M = {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require('lspkind')

    local sources = {
      { name = "nvim_lsp" },
      { name = "buffer", keyword_length = 2 },
      { name = "path" },
    }

    cmp.setup({
      preselect = cmp.PreselectMode.None,
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = function(fallback)
          if cmp.visible() then
            cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
          else
            fallback()
          end
        end,
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            else
              cmp.select_next_item()
            end
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then
              cmp.confirm({ select = true })
            end
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = sources,
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol',
          maxwidth = 120,
          minwidth = 90,
          ellipsis_char = '...',
          show_labelDetails = true,
        })
      },
    })
  end,
}


return M
