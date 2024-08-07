local themes = {
  kanagawa = {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("thunder.plugins.specs.themes.kanagawa")
    end,
  },
  catppuccin = {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("thunder.plugins.specs.themes.catppuccin")
    end,
  },
}

return themes.catppuccin
