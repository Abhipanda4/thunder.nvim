highlight clear
if exists('syntax_on')
    syntax reset
endif
syntax reset

let g:colors_name = "thunder"

let s:red1 = "#F28D92"
let s:red2 = "#EC5F67"
let s:green1 = "#8FEFB3"
let s:blue1 = "#BDFFFF"
let s:blue2 = "#56AFFF"
let s:cyan1 = "#00B386"
let s:cyan2 = "#00BFBF"
let s:yellow1 = "#FAC863"
let s:yellow2 = "#FB8C00"
let s:yellow3 = "#FFE699"
let s:purple1 = "#D678DD"
let s:magenta1 = "#D9B3FF"
let s:magenta2 = "C678DD"
let s:light = "#F0FFFF"
let s:grey1 = "#71818E"
let s:grey2 = "#484D4F"
let s:grey3 = "#292C36"
let s:dark = "#20252d"

let g:color_palette = {
      \ "red1": s:red1,
      \ "red2": s:red2,
      \ "green1": s:green1,
      \ "blue1": s:blue1,
      \ "blue2": s:blue2,
      \ "cyan1": s:cyan1,
      \ "cyan2": s:cyan2,
      \ "yellow1": s:yellow1,
      \ "yellow2": s:yellow2,
      \ "yellow3": s:yellow3,
      \ "purple1": s:purple1,
      \ "magenta1": s:magenta1,
      \ "magenta2": s:magenta2,
      \ "grey1": s:grey1,
      \ "grey2": s:grey2,
      \ "grey3": s:grey3,
      \ "light": s:light,
      \ "dark": s:dark,
      \ }

function! s:h(group, style)
    execute "highlight" a:group
      \ "guifg="   (has_key(a:style, "fg")   ? a:style.fg    : "NONE")
      \ "guibg="   (has_key(a:style, "bg")   ? a:style.bg    : "NONE")
      \ "gui="     (has_key(a:style, "gui")  ? a:style.gui   : "NONE")
endfunction


call s:h("Comment", { "fg": s:grey1 })
call s:h("Constant", { "fg": s:yellow2 })
call s:h("Boolean", { "fg": s:yellow2 })
call s:h("Number", { "fg": s:purple1 })
call s:h("Float", { "fg": s:purple1 })
call s:h("Character", { "fg": s:green1 })
call s:h("String", { "fg": s:green1 })
call s:h("Identifier", { "fg": s:cyan2 })
call s:h("Function", { "fg": s:blue2 })
call s:h("Statement", { "fg": s:red2, "gui": "bold" })
call s:h("Conditional", { "fg": s:purple1, "gui": "bold" })
call s:h("Repeat", { "fg": s:red2, "gui": "bold"})
call s:h("Label", { "fg": s:red2, "gui": "bold" })
call s:h("Operator", { "fg": s:yellow3 })
call s:h("Keyword", { "fg": s:purple1, "gui": "bold" })
call s:h("Exception", { "fg": s:red2, "gui": "bold" })
call s:h("PreProc", { "fg": s:purple1, "gui": "bold" })
call s:h("Include", { "fg": s:purple1, "gui": "bold" })
call s:h("Define", { "fg": s:blue2 })
call s:h("Macro", { "fg": s:blue2 })
call s:h("PreCondit", { "fg": s:yellow1 })
call s:h("Type", { "fg": s:yellow1, "gui": "bold" })
call s:h("StorageClass", { "fg": s:yellow1, "gui": "bold" })
call s:h("Structure", { "fg": s:yellow1, "gui": "bold" })
call s:h("Typedef", { "fg": s:purple1, "gui": "bold" })
" call s:h("Special", { "fg": s:blue })
call s:h("Tag", {"fg": s:red2})
call s:h("Delimiter", { "fg": s:yellow3 })
" call s:h("SpecialChar", {})
" call s:h("SpecialComment", { "fg": s:comment_grey })
" call s:h("Debug", {})
call s:h("Underlined", { "gui": "underline" })
call s:h("Ignore", {})
call s:h("Error", { "bg": s:red1, "fg": s:dark })
" call s:h("Todo", { "fg": s:green2, "gui": "bold" })
call s:h("ColorColumn", { "bg": s:grey3 })
call s:h("CursorLine", { "bg": s:grey3 })
call s:h("CursorLineNr", {})
call s:h("LineNr", { "fg": s:grey2 })
call s:h("SignColumn", {})
call s:h("VertSplit", { "fg": s:grey1 })
call s:h("Pmenu", { "bg": s:grey3 })
call s:h("PmenuSel", { "fg": s:dark, "bg": s:blue2 })
call s:h("PmenuSbar", { "bg": s:grey3 })
call s:h("PmenuThumb", { "bg": s:grey1 })
call s:h("Statusline", {})
call s:h("StatuslineNC", { "fg": s:dark, "bg": s:dark })
call s:h("TabLine", {})
call s:h("TabLineFill", {})
call s:h("TabLineSel", { "fg": s:light })
call s:h("Normal", { "fg": s:light, "bg": s:dark })
call s:h("NormalFloat", { "fg": s:light, "bg": s:grey3 })
call s:h("Visual", { "bg": s:grey2 })
call s:h("NonText", { "bg": s:dark, "fg": s:dark })
call s:h("IncSearch", { "fg": s:dark, "bg": s:cyan1 })
call s:h("Search", { "fg": s:dark, "bg": s:yellow1 })
" call s:h("Substitute", { "bg": s:green2, "fg": s:dark, "gui": "bold" })
" call s:h("MatchParen", { "fg": s:red2, "gui": "underline" })
call s:h("Question", { "fg": s:green1 })
call s:h("MoreMsg", {"fg": s:green1})
call s:h("ErrorMsg", { "bg": s:red1, "fg": s:dark })
" call s:h("Conceal", {})
" call s:h("Cursor", { "fg": s:dark, "bg": s:light })
" call s:h("CursorIM", {})
" call s:h("CursorColumn", { "bg": s:grey2 })
" call s:h("Directory", { "fg": s:blue })
" call s:h("ModeMsg", {})
" call s:h("SpecialKey", { "fg": s:special_grey })
" call s:h("SpellBad", { "fg": s:red, "gui": "underline" })
" call s:h("SpellCap", { "fg": s:dark_yellow })
" call s:h("SpellLocal", { "fg": s:dark_yellow })
" call s:h("SpellRare", { "fg": s:dark_yellow })
" call s:h("Title", { "fg": s:white, "gui": "bold" })
" call s:h("VisualNOS", { "bg": s:red2 })
" call s:h("WarningMsg", { "fg": s:yellow })
" call s:h("WildMenu", { "fg": s:black, "bg": s:blue })
" call s:h("Folded", { "bg": s:cursor_grey, "fg": s:comment_grey })
call s:h("FoldColumn", {})
call s:h("DiffAdd", { "fg": s:dark, "bg": s:green1 })
call s:h("DiffDelete", { "fg": s:dark, "bg": s:red2 })
call s:h("DiffText", { "fg": s:dark, "bg": s:blue2 })
call s:h("DiffChange", { "fg": s:light, "bg": s:grey2 })

" Statusline higroups
call s:h("User1", { "fg": s:dark, "bg": s:cyan2, "gui": "bold" })
call s:h("User2", { "fg": s:dark, "bg": s:yellow1, "gui": "bold" })
call s:h("User3", { "fg": s:dark, "bg": s:purple1 })
call s:h("User4", { "fg": s:dark, "bg": s:blue2 })
call s:h("User5", { "fg": s:light })
call s:h("User6", { "fg": s:purple1 })
call s:h("User7", { "fg": s:light })
call s:h("User8", { "fg": s:light, "bg": s:grey3 })
call s:h("User9", { "fg": s:light, "bg": s:grey3 })

" Treesitter highlights
call s:h('TSBoolean',  { "fg": s:magenta1, "gui": "bold" })
call s:h('TSCharacter',  { "fg": s:green1 })
call s:h('TSConditional', { "fg": s:cyan2, "gui": "bold" })
call s:h('TSConstant',  { "fg": s:yellow2, "gui": "bold" })
call s:h('TSConstructor',  { "fg": s:purple1, "gui": "bold" })
call s:h('TSField', { "fg": s:yellow1 })
call s:h('TSFloat',  { "fg": s:magenta1 })
call s:h('TSFuncBuiltin', { "fg": s:red2 })
call s:h('TSFunction', { "fg": s:blue2, "gui": "bold" })
call s:h('TSInclude', { "fg": s:blue2 })
call s:h('TSKeyword', { "fg": s:purple1 })
call s:h('TSKeywordOperator', { "fg": s:cyan2 })
call s:h('TSMethod', { "fg": s:blue2 })
call s:h('TSNamespace', { "fg": s:red2 })
call s:h('TSNumber',  { "fg": s:magenta1 })
call s:h('TSOperator', { "fg": s:yellow3 })
call s:h('TSParameter', { "fg": s:blue1 })
call s:h('TSPunctBracket', { "fg": s:yellow3 })
call s:h('TSPunctDelimiter', { "fg": s:yellow3 })
call s:h('TSRepeat', { "fg": s:cyan2, "gui": "bold" })
call s:h('TSString',  { "fg": s:green1 })
call s:h('TSStringRegex',  { "fg": s:green1 })
call s:h('TSTypeBuiltin', { "fg": s:yellow1 })
call s:h('TSVariable', { "fg": s:light })
call s:h('TSVariableBuiltin', { "fg": s:red2, "gui": "bold" })

" LSP utils
call s:h("LspDiagnosticsSignError", { "fg": s:red2, "bg": s:dark })
call s:h("LspDiagnosticsSignWarning", { "fg": s:yellow1, "bg": s:dark })
call s:h("LspDiagnosticsSignInformation", { "fg": s:cyan1, "bg": s:dark })
call s:h("LspDiagnosticsSignHint", { "fg": s:cyan1, "bg": s:dark })

call s:h("LspDiagnosticsPreviewError", { "fg": s:red2, "bg": s:dark })
call s:h("LspDiagnosticsPreviewWarning", { "fg": s:yellow1, "bg": s:dark })
call s:h("LspDiagnosticsPreviewInformation", { "fg": s:cyan1, "bg": s:dark })
call s:h("LspDiagnosticsPreviewHint", { "fg": s:cyan1, "bg": s:dark })

sign define LspDiagnosticsSignError text=▊ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=▊ texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=▊ texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=▊ texthl=LspDiagnosticsSignHint linehl= numhl=

" Plugins
call s:h('CleverFDefaultLabel', {"fg": s:yellow2, "gui": "bold,underline"})
call s:h('NvimTreeFolderName', {"fg": s:blue2})
call s:h('NvimTreeFolderIcon', {"fg": s:purple1})
