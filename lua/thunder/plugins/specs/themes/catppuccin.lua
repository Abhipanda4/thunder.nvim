require("catppuccin").setup({
    flavour = "auto",
    background = {
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = function(colors)
        return {
            CleverFDefaultLabel = { fg = colors.maroon, style = { "bold", "underline" } },
        }
    end,
    default_integrations = false,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
