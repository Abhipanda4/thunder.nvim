" Custom colorscheme with modifications from onedark colorscheme

highlight clear
if exists('syntax_on')
    syntax reset
endif

let g:colors_name = "thunder"

let s:red = "#e06c75"
let s:green = "#89ca78"
let s:yellow = "#E5C07B"
let s:dark_yellow = "#d8985f"
let s:blue = "#52adf2"
let s:purple = "#cd78df"
let s:cyan = "#00BFBF"
let s:white = "#ABB2BF"
let s:temp = "#BFB2AB"
let s:black = "#282C34"
let s:visual_black = "#2B2C38"
let s:comment_grey = "#5C6370"
let s:gutter_fg_grey = "#4B5263"
let s:cursor_grey = "#2C323C"
let s:visual_grey = "#3E4452"
let s:menu_grey = "#21252b"
let s:special_grey = "#3B4048"
let s:vertsplit = "#181A1F"

let g:color_palette = {
      \ "red": s:red,
      \ "green": s:green,
      \ "blue": s:blue,
      \ "cyan": s:cyan,
      \ "yellow": s:yellow,
      \ "dark_yellow": s:dark_yellow,
      \ "purple": s:purple,
      \ "white": s:white,
      \ "black": s:black,
      \ "grey": s:comment_grey,
      \ "menu_grey": s:menu_grey
      \ }

function! s:h(group, style)
    execute "highlight" a:group
      \ "guifg="   (has_key(a:style, "fg")   ? a:style.fg    : "NONE")
      \ "guibg="   (has_key(a:style, "bg")   ? a:style.bg    : "NONE")
      \ "gui="     (has_key(a:style, "gui")  ? a:style.gui   : "NONE")
endfunction


call s:h("Comment", { "fg": s:comment_grey, "gui": "italic", "cterm": "italic" })
call s:h("Constant", { "fg": s:cyan })
call s:h("String", { "fg": s:green })
call s:h("Character", { "fg": s:green })
call s:h("Number", { "fg": s:dark_yellow })
call s:h("Boolean", { "fg": s:dark_yellow })
call s:h("Float", { "fg": s:dark_yellow })
call s:h("Identifier", { "fg": s:red })
call s:h("Function", { "fg": s:blue })
call s:h("Statement", { "fg": s:purple })
call s:h("Conditional", { "fg": s:purple })
call s:h("Repeat", { "fg": s:purple })
call s:h("Label", { "fg": s:purple })
call s:h("Operator", { "fg": s:purple })
call s:h("Keyword", { "fg": s:red })
call s:h("Exception", { "fg": s:purple })
call s:h("PreProc", { "fg": s:yellow })
call s:h("Include", { "fg": s:blue })
call s:h("Define", { "fg": s:purple })
call s:h("Macro", { "fg": s:purple })
call s:h("PreCondit", { "fg": s:yellow })
call s:h("Type", { "fg": s:yellow })
call s:h("StorageClass", { "fg": s:yellow })
call s:h("Structure", { "fg": s:yellow })
call s:h("Typedef", { "fg": s:yellow })
call s:h("Special", { "fg": s:blue })
call s:h("SpecialChar", { "fg": s:dark_yellow })
call s:h("Tag", {})
call s:h("Delimiter", {})
call s:h("SpecialComment", { "fg": s:comment_grey })
call s:h("Debug", {})
call s:h("Underlined", { "gui": "underline", "cterm": "underline" })
call s:h("Ignore", {})
call s:h("Error", { "fg": s:red })
call s:h("Todo", { "fg": s:purple })

call s:h("ColorColumn", { "bg": s:cursor_grey })
call s:h("Conceal", {})
call s:h("Cursor", { "fg": s:black, "bg": s:blue })
call s:h("CursorIM", {})
call s:h("CursorColumn", { "bg": s:cursor_grey })
call s:h("CursorLine", { "bg": s:cursor_grey })
call s:h("Directory", { "fg": s:blue })
call s:h("DiffAdd", { "bg": s:green, "fg": s:black })
call s:h("DiffChange", { "fg": s:yellow, "gui": "underline", "cterm": "underline" })
call s:h("DiffDelete", { "bg": s:red, "fg": s:black })
call s:h("DiffText", { "bg": s:yellow, "fg": s:black })
call s:h("EndOfBuffer", { "fg": s:black })
call s:h("ErrorMsg", { "fg": s:red })
call s:h("VertSplit", { "fg": s:vertsplit })
call s:h("Folded", { "fg": s:comment_grey })
call s:h("FoldColumn", {})
call s:h("SignColumn", {})
call s:h("IncSearch", { "fg": s:yellow, "bg": s:comment_grey })
call s:h("LineNr", { "fg": s:gutter_fg_grey })
call s:h("CursorLineNr", {})
call s:h("MatchParen", { "fg": s:blue, "gui": "underline", "cterm": "underline" })
call s:h("ModeMsg", {})
call s:h("MoreMsg", {})
call s:h("NonText", { "fg": s:special_grey })
call s:h("Normal", { "fg": s:white, "bg": s:black })
call s:h("NormalFloat", { "fg": s:white, "bg": s:menu_grey })
call s:h("Pmenu", { "bg": s:menu_grey })
call s:h("PmenuSel", { "fg": s:black, "bg": s:blue })
call s:h("PmenuSbar", { "bg": s:special_grey })
call s:h("PmenuThumb", { "bg": s:white })
call s:h("Question", { "fg": s:purple })
call s:h("QuickFixLine", { "fg": s:black, "bg": s:yellow })
call s:h("Search", { "fg": s:black, "bg": s:yellow })
call s:h("SpecialKey", { "fg": s:special_grey })
call s:h("SpellBad", { "fg": s:red, "gui": "underline", "cterm": "underline" })
call s:h("SpellCap", { "fg": s:dark_yellow })
call s:h("SpellLocal", { "fg": s:dark_yellow })
call s:h("SpellRare", { "fg": s:dark_yellow })
call s:h("StatusLine", { "fg": s:black, "bg": s:black })
call s:h("StatusLineNC", { "bg": s:cursor_grey })
call s:h("StatusLineTerm", { "fg": s:white, "bg": s:black })
call s:h("StatusLineTermNC", { "bg": s:cursor_grey })
call s:h("TabLine", { "fg": s:comment_grey })
call s:h("TabLineFill", {})
call s:h("TabLineSel", { "fg": s:white })
call s:h("Terminal", { "fg": s:white, "bg": s:black })
call s:h("Title", { "fg": s:green })
call s:h("Visual", { "bg": s:visual_grey })
call s:h("VisualNOS", { "bg": s:visual_grey })
call s:h("WarningMsg", { "fg": s:yellow })
call s:h("WildMenu", { "fg": s:black, "bg": s:blue })

" Treesitter highlights
call s:h('TSBoolean',  { "fg": s:dark_yellow })
call s:h('TSCharacter',  { "fg": s:green })
call s:h('TSConditional', { "fg": s:purple })
call s:h('TSConstant',  { "fg": s:white, "gui": "bold" })
call s:h('TSConstBuiltin',  { "fg": s:cyan, "gui": "bold" })
call s:h('TSConstructor',  { "fg": s:cyan, "gui": "bold" })
call s:h('TSField', { "fg": s:temp })
call s:h('TSFloat',  { "fg": s:dark_yellow })
call s:h('TSFuncBuiltin', { "fg": s:blue, "gui": "bold" })
call s:h('TSFunction', { "fg": s:blue })
call s:h('TSInclude', { "fg": s:purple })
call s:h('TSKeyword', { "fg": s:purple })
call s:h('TSKeywordOperator', { "fg": s:purple })
call s:h('TSMethod', { "fg": s:blue })
" call s:h('TSNamespace', { "fg": s:red2 })
call s:h('TSNumber',  { "fg": s:dark_yellow })
call s:h('TSOperator', { "fg": s:purple })
call s:h('TSParameter', { "fg": s:dark_yellow })
call s:h('TSPunctBracket', { "fg": s:purple })
call s:h('TSPunctDelimiter', { "fg": s:white })
call s:h('TSRepeat', { "fg": s:purple })
call s:h('TSString',  { "fg": s:green })
call s:h('TSStringRegex',  { "fg": s:green })
call s:h('TSType', { "fg": s:yellow })
call s:h('TSTypeBuiltin', { "fg": s:cyan })
call s:h('TSVariable', { "fg": s:white })
call s:h('TSVariableBuiltin', { "fg": s:red })

" LSP utils
call s:h("LspDiagnosticsSignError", { "fg": s:red, "bg": s:black })
call s:h("LspDiagnosticsSignWarning", { "fg": s:dark_yellow, "bg": s:black })
call s:h("LspDiagnosticsSignInformation", { "fg": s:green, "bg": s:black })
call s:h("LspDiagnosticsSignHint", { "fg": s:green, "bg": s:black })

call s:h("LspDiagnosticsPreviewError", { "fg": s:red, "bg": s:black })
call s:h("LspDiagnosticsPreviewWarning", { "fg": s:dark_yellow, "bg": s:black })
call s:h("LspDiagnosticsPreviewInformation", { "fg": s:green, "bg": s:black })
call s:h("LspDiagnosticsPreviewHint", { "fg": s:green, "bg": s:black })

sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

" Plugins
call s:h('CleverFDefaultLabel', {"fg": s:yellow, "gui": "bold,underline"})
call s:h('NvimTreeFolderName', {"fg": s:blue})
call s:h('NvimTreeFolderIcon', {"fg": s:yellow})
call s:h('NvimTreeRootFolder', {"fg": s:purple})
