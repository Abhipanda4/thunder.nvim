" ====================================================================
" Name: colors/thunder.vim
" Description: Custom colorscheme "thunder" based on atom one-dark
" Maintainer: Abhisek Panda <abhipanda03@gmail.com>
" ====================================================================

highlight clear
if exists('syntax_on')
    syntax reset
endif
syntax reset

let g:colors_name = "thunder"

let s:red = g:thunder_color_palette.red
let s:light_red = g:thunder_color_palette.light_red
let s:dark_red = g:thunder_color_palette.dark_red
let s:green = g:thunder_color_palette.green
let s:yellow = g:thunder_color_palette.yellow
let s:dark_yellow = g:thunder_color_palette.dark_yellow
let s:bright_yellow = g:thunder_color_palette.bright_yellow
let s:blue = g:thunder_color_palette.blue
let s:purple = g:thunder_color_palette.purple
let s:cyan1 = g:thunder_color_palette.cyan1
let s:cyan2 = g:thunder_color_palette.cyan2
let s:white = g:thunder_color_palette.white
let s:black = g:thunder_color_palette.black
let s:light_black = g:thunder_color_palette.light_black
let s:dark_black = g:thunder_color_palette.dark_black
let s:comment_grey = g:thunder_color_palette.comment_grey
let s:gutter_fg_grey = g:thunder_color_palette.gutter_fg_grey
let s:cursor_grey = g:thunder_color_palette.cursor_grey
let s:visual_grey = g:thunder_color_palette.visual_grey
let s:menu_grey = g:thunder_color_palette.menu_grey
let s:special_grey = g:thunder_color_palette.special_grey

function! s:h(group, style)
    execute "highlight" a:group
      \ "guifg="   (has_key(a:style, "fg")   ? a:style.fg    : "NONE")
      \ "guibg="   (has_key(a:style, "bg")   ? a:style.bg    : "NONE")
      \ "gui="     (has_key(a:style, "gui")  ? a:style.gui   : "NONE")
endfunction

call s:h("Comment", { "fg": s:comment_grey, "gui": "italic" })
call s:h("Constant", { "fg": s:cyan1 })
call s:h("String", { "fg": s:green })
call s:h("Character", { "fg": s:green })
call s:h("Number", { "fg": s:dark_yellow })
call s:h("Boolean", { "fg": s:dark_yellow })
call s:h("Float", { "fg": s:dark_yellow })
call s:h("Identifier", { "fg": s:light_red })
call s:h("Function", { "fg": s:blue })
call s:h("Statement", { "fg": s:purple })
call s:h("Conditional", { "fg": s:purple })
call s:h("Repeat", { "fg": s:purple })
call s:h("Label", { "fg": s:purple })
call s:h("Operator", { "fg": s:cyan1 })
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
call s:h("SpecialChar", {})
call s:h("Tag", {})
call s:h("Delimiter", {})
call s:h("SpecialComment", { "fg": s:comment_grey })
call s:h("Debug", {})
call s:h("Underlined", { "gui": "underline" })
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
call s:h("ErrorMsg", { "fg": s:red })
call s:h("VertSplit", { "fg": s:dark_black })
call s:h("Folded", { "bg": s:cursor_grey, "fg": s:comment_grey })
call s:h("FoldColumn", {})
call s:h("SignColumn", {})
call s:h("IncSearch", { "fg": s:black, "bg": s:cyan1 })
call s:h("LineNr", { "fg": s:gutter_fg_grey })
call s:h("CursorLineNr", {})
call s:h("MatchParen", { "fg": s:blue, "gui": "underline" })
call s:h("ModeMsg", {})
call s:h("MoreMsg", {})
call s:h("NonText", { "fg": s:special_grey })
call s:h("Normal", { "fg": s:white, "bg": s:black })
call s:h("NormalFloat", { "fg": s:white, "bg": s:light_black })
call s:h("Pmenu", { "bg": s:menu_grey })
call s:h("PmenuSel", { "fg": s:black, "bg": s:blue })
call s:h("PmenuSbar", { "bg": s:special_grey })
call s:h("PmenuThumb", { "bg": s:white })
call s:h("Question", { "fg": s:purple })
call s:h("Search", { "fg": s:black, "bg": s:yellow })
call s:h("SpecialKey", { "fg": s:special_grey })
call s:h("SpellBad", { "fg": s:red, "gui": "underline" })
call s:h("SpellCap", { "fg": s:dark_yellow })
call s:h("SpellLocal", { "fg": s:dark_yellow })
call s:h("SpellRare", { "fg": s:dark_yellow })
call s:h("Statusline", {})
call s:h("StatuslineNC", { "fg": s:black, "bg": s:black })
call s:h("TabLine", {})
call s:h("TabLineFill", {})
call s:h("TabLineSel", { "fg": s:white })
call s:h("Title", { "fg": s:white, "gui": "bold" })
call s:h("Visual", { "bg": s:visual_grey })
call s:h("VisualNOS", { "bg": s:visual_grey })
call s:h("WarningMsg", { "fg": s:yellow })
call s:h("WildMenu", { "fg": s:black, "bg": s:blue })

" User Highlight Groups for Statusline
call s:h("User1", { "fg": s:black, "bg": s:green })
call s:h("User2", { "fg": s:black, "bg": s:blue })
call s:h("User3", { "fg": s:black, "bg": s:purple })
call s:h("User4", { "fg": s:black, "bg": s:red })
call s:h("User5", { "fg": s:white, "bg": s:black })
call s:h("User6", { "fg": s:black, "bg": s:comment_grey })


" Sparx Explorer color groups
call s:h('SparxDirectory', { "fg": s:blue, "bg": s:black })
call s:h('SparxDirectoryIcon', { "fg": s:purple, "bg": s:black })
call s:h('SparxFile', { "fg": s:white, "bg": s:black })
call s:h('SparxFileIcon', { "fg": s:green, "bg": s:black })
call s:h('SparxLink', { "fg": s:red, "bg": s:black })
call s:h('SparxLinkIcon', { "fg": s:red, "bg": s:black })

" LSP color groups
call s:h('LspDiagnosticsOk', { "fg": s:cyan2, 'gui': 'bold' })
call s:h('LspDiagnosticsError', { "fg": s:red })
call s:h('LspDiagnosticsWarning', { "fg": s:yellow })
call s:h('LspDiagnosticsInfo', { "fg": s:green })
call s:h('LspDiagnosticsHint', { "fg": s:green })
call s:h('LspDiagnosticsErrorSign', { "fg": s:red, "bg": s:black })
call s:h('LspDiagnosticsWarningSign', { "fg": s:yellow, "bg": s:black })
call s:h('LspDiagnosticsInformationSign', { "fg": s:green, "bg": s:black })
call s:h('LspDiagnosticsHintSign', { "fg": s:green, "bg": s:black })

sign define LspDiagnosticsErrorSign        text=●  texthl=LspDiagnosticsErrorSign        linehl= numhl=
sign define LspDiagnosticsWarningSign      text=●  texthl=LspDiagnosticsWarningSign      linehl= numhl=
sign define LspDiagnosticsInformationSign  text=●  texthl=LspDiagnosticsInformationSign  linehl= numhl=
sign define LspDiagnosticsHintSign         text=●  texthl=LspDiagnosticsHintSign         linehl= numhl=

" Highlight groups for 3rd party plugins
call s:h('CleverFDefaultLabel', { "fg": s:dark_yellow, "gui": "bold,underline" })
