local gl = require("galaxyline")
local buffer = require("galaxyline.provider_buffer")
local colors = require("galaxyline.theme").default
local condition = require("galaxyline.condition")
local gls = gl.section

gl.short_line_list = {"NvimTree", "qf", "undotree", "diff"}

gls.left[1] = {
  LeftIndicator = {
    provider = function()
      return "▊ "
    end,
    highlight = {colors.blue, colors.bg}
  }
}

gls.left[2] = {
  ViMode = {
    provider = function()
      local mode_color = {
        n = colors.red,
        i = colors.green,
        v = colors.blue,
        [""] = colors.blue,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ["r?"] = colors.cyan,
        ["!"] = colors.red,
        t = colors.red
      }
      vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
      return " "
    end,
    highlight = {colors.red, colors.bg, "bold"}
  }
}
gls.left[3] = {
  GitBranch = {
    provider = "GitBranch",
    icon = "  ",
    condition = condition.check_git_workspace,
    highlight = {colors.violet, colors.bg, "bold"},
    separator = " ",
    separator_highlight = {"NONE", colors.bg}
  }
}

gls.left[4] = {
  FileIcon = {
    provider = "FileIcon",
    condition = condition.buffer_not_empty,
    highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg}
  }
}

gls.left[5] = {
  FileName = {
    provider = "FileName",
    condition = condition.buffer_not_empty,
    highlight = {colors.magenta, colors.bg, "bold"}
  }
}

gls.left[6] = {
  ShowLspClient = {
    provider = "GetLspClient",
    condition = function()
      local tbl = {["dashboard"] = true, [""] = true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = "  ",
    separator_highlight = {"NONE", colors.bg},
    highlight = {colors.fg, colors.bg, "bold"}
  }
}

gls.right[1] = {
  DiagnosticError = {
    provider = "DiagnosticError",
    icon = "  ",
    highlight = {colors.red, colors.bg}
  }
}
gls.right[2] = {
  DiagnosticWarn = {
    provider = "DiagnosticWarn",
    icon = "  ",
    highlight = {colors.yellow, colors.bg}
  }
}

gls.right[3] = {
  DiagnosticHint = {
    provider = "DiagnosticHint",
    icon = "  ",
    highlight = {colors.cyan, colors.bg}
  }
}

gls.right[4] = {
  DiagnosticInfo = {
    provider = "DiagnosticInfo",
    icon = "  ",
    highlight = {colors.blue, colors.bg}
  }
}

gls.right[5] = {
  LineColumn = {
    provider = "LineColumn",
    separator = " ",
    separator_highlight = {"NONE", colors.bg},
    highlight = {colors.fg, colors.bg, "bold"}
  }
}

gls.right[6] = {
  PerCent = {
    provider = "LinePercent",
    separator = " ",
    separator_highlight = {"NONE", colors.bg},
    highlight = {colors.fg, colors.bg, "bold"}
  }
}

gls.right[7] = {
  RainbowBlue = {
    provider = function()
      return " ▊"
    end,
    highlight = {colors.blue, colors.bg}
  }
}

gls.short_line_left[1] = {
  Filetype = {
     provider = function()
       local ft = buffer.get_buffer_filetype()
       if ft == "QF" then
         return "QuickFix"
       end
       return ft
     end,
     separator = " ",
     separator_highlight = {"NONE", colors.bg},
     highlight = {colors.blue, colors.bg, "bold"}
  }
}

gls.short_line_right[1] = {
  LineColumn = {
    provider = "LineColumn",
    separator = " ",
    separator_highlight = {"NONE", colors.bg},
    highlight = {colors.fg, colors.bg, "bold"}
  }
}
