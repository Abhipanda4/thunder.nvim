local M = {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    filters = {
      dotfiles = true,
    },
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      adaptive_size = false,
      side = "left",
      width = 40,
      preserve_window_proportions = true,
    },
    git = {
      enable = true,
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      highlight_git = "icon",
      add_trailing = true,
      group_empty = true,
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
  },
  keys = {
    { "<leader>n", "<cmd>NvimTreeToggle <cr>", desc="Toggle Nvimtree" },
  },
}

return M
