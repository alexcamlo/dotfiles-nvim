local palette_dark = {
  grey1 = "#020617",
  grey2 = "#0f172a",
  grey3 = "#1e293b",
  grey4 = "#475569",
  blue = "#0c4a6e",
  cyan = "#164e63",
  green = "#14532d",
  magenta = "#831843",
  red = "#7f1d1d",
  yellow = "#78350f",
}

local palette_light = {
  grey1 = "#f1f5f9",
  grey2 = "#e2e8f0",
  grey3 = "#cbd5e1",
  grey4 = "#94a3b8",
  blue = "#74d4ff",
  cyan = "#67e8f9",
  green = "#34d399",
  magenta = "#FB64B6",
  red = "#f87171",
  yellow = "#fcd34d",
}

vim.cmd("hi clear")
vim.g.colors_name = "default_tailwind"

-- In 'background=dark' dark colors are used for background and light - for
-- foreground. In 'background=light' they reverse.
-- Inline comments show basic highlight group assuming dark background

local is_dark = vim.o.background == "dark"
local bg = is_dark and palette_dark or palette_light
local fg = is_dark and palette_light or palette_dark

-- Source for actual groups: 'src/nvim/highlight_group.c' in Neovim source code
--stylua: ignore start
local hi = function(name, data) vim.api.nvim_set_hl(0, name, data) end

hi('ColorColumn',          { fg=nil,       bg=bg.grey1 })
hi('Conceal',              { fg=bg.grey4,  bg=nil })
hi('CurSearch',            { link='Search' })
hi('Cursor',               { fg=nil,       bg=nil })
hi('CursorColumn',         { fg=nil,       bg=bg.grey3 })
hi('CursorIM',             { link='Cursor' })
hi('CursorLine',           { fg=nil,       bg=bg.grey3 })
hi('CursorLineFold',       { link='FoldColumn' })
hi('CursorLineNr',         { fg=nil,       bg=nil,      bold=true })
hi('CursorLineSign',       { link='SignColumn' })
hi('DiffAdd',              { fg=fg.grey1,  bg=bg.green })
hi('DiffChange',           { fg=fg.grey1,  bg=bg.grey4 })
hi('DiffDelete',           { fg=fg.red,    bg=nil,      bold=true })
hi('DiffText',             { fg=fg.grey1,  bg=bg.magenta })
hi('Directory',            { fg=fg.magenta,   bg=nil })
hi('EndOfBuffer',          { link='NonText' })
hi('ErrorMsg',             { fg=fg.red,    bg=nil })
hi('FloatBorder',          { link='NormalFloat' })
hi('FloatShadow',          { fg=bg.grey1,  bg=nil,      blend=80 })
hi('FloatShadowThrough',   { fg=bg.grey1,  bg=nil,      blend=100 })
hi('FloatTitle',           { link='Title' })
hi('FoldColumn',           { link='SignColumn' })
hi('Folded',               { fg=fg.grey4,  bg=bg.grey3 })
hi('IncSearch',            { link='Search' })
hi('lCursor',              { fg=bg.grey2,  bg=fg.grey2 })
hi('LineNr',               { fg=bg.grey4,  bg=nil })
hi('LineNrAbove',          { link='LineNr' })
hi('LineNrBelow',          { link='LineNr' })
hi('MatchParen',           { fg=nil,       bg=bg.grey4, bold=true })
hi('ModeMsg',              { fg=fg.green,  bg=nil })
hi('MoreMsg',              { fg=fg.magenta,   bg=nil })
hi('MsgArea',              { fg=nil,       bg=nil })
hi('MsgSeparator',         { link='StatusLine' })
hi('NonText',              { fg=bg.grey4,  bg=nil })
hi('Normal',               { fg=fg.grey2,  bg=bg.grey2 })
hi('NormalFloat',          { fg=fg.grey2,  bg=bg.grey2 })
hi('NormalNC',             { fg=nil,       bg=nil })
hi('PMenu',                { fg=fg.grey2,  bg=bg.grey3 })
hi('PMenuExtra',           { link='PMenu' })
hi('PMenuExtraSel',        { link='PMenuSel' })
hi('PMenuKind',            { link='PMenu' })
hi('PMenuKindSel',         { link='PMenuSel' })
hi('PMenuSbar',            { link='PMenu' })
hi('PMenuSel',             { fg=bg.grey3,  bg=fg.grey2, blend=0 })
hi('PMenuThumb',           { fg=nil,       bg=bg.grey4 })
hi('Question',             { fg=fg.magenta,   bg=nil })
hi('QuickFixLine',         { fg=nil,       bg=nil,      bold=true })
hi('RedrawDebugNormal',    { fg=nil,       bg=nil,      reverse=true })
hi('RedrawDebugClear',     { fg=nil,       bg=bg.magenta })
hi('RedrawDebugComposed',  { fg=nil,       bg=bg.green })
hi('RedrawDebugRecompose', { fg=nil,       bg=bg.red })
hi('Search',               { fg=fg.grey1,  bg=bg.yellow})
hi('SignColumn',           { fg=bg.grey4,  bg=nil })
hi('SpecialKey',           { fg=bg.grey4,  bg=nil })
hi('SpellBad',             { fg=nil,       bg=nil,      sp=fg.red,    undercurl=true })
hi('SpellCap',             { fg=nil,       bg=nil,      sp=fg.yellow, undercurl=true })
hi('SpellLocal',           { fg=nil,       bg=nil,      sp=fg.green,  undercurl=true })
hi('SpellRare',            { fg=nil,       bg=nil,      sp=fg.magenta,   undercurl=true })
hi('StatusLine',           { fg=fg.grey3,  bg=bg.grey1 })
hi('StatusLineNC',         { fg=fg.grey4,  bg=bg.grey1 })
hi('Substitute',           { link='Search' })
hi('TabLine',              { fg=fg.grey3,  bg=bg.grey1 })
hi('TabLineFill',          { link='Tabline' })
hi('TabLineSel',           { fg=nil,       bg=nil,      bold = true })
hi('TermCursor',           { fg=nil,       bg=nil,      reverse=true })
hi('TermCursorNC',         { fg=nil,       bg=nil,      reverse=true })
hi('Title',                { fg=nil,       bg=nil,      bold=true })
hi('VertSplit',            { link='WinSeparator' })
hi('Visual',               { fg=nil,       bg=bg.grey4 })
hi('VisualNOS',            { link='Visual' })
hi('WarningMsg',           { fg=fg.yellow, bg=nil })
hi('Whitespace',           { link='NonText' })
hi('WildMenu',             { link='PMenuSel' })
hi('WinBar',               { link='StatusLine' })
hi('WinBarNC',             { link='StatusLineNC' })
hi('WinSeparator',         { link='Normal' })

-- Syntax (`:h group-name`)
hi('Comment', { fg=fg.grey4, bg=nil })

hi('Constant',  { fg=fg.grey2, bg=nil })
hi('String',    { fg=fg.grey1, bg=nil })
hi('Character', { link='Constant' })
hi('Number',    { link='Constant' })
hi('Boolean',   { link='Constant' })
hi('Float',     { link='Number' })

hi('Identifier', { fg=fg.blue, bg=nil }) -- frequent but important to get "main" branded color
hi('Function',   { fg=fg.magenta, bg=nil }) -- not so frequent but important to get "main" branded color

hi('Statement',   { fg=fg.grey2, bg=nil, bold=true }) -- bold choice (get it?) for accessibility
hi('Conditional', { link='Statement' })
hi('Repeat',      { link='Statement' })
hi('Label',       { link='Statement' })
hi('Operator',    { fg=fg.grey2, bg=nil }) -- seems too much to be bold for mostly singl-character words
hi('Keyword',     { link='Statement' })
hi('Exception',   { link='Statement' })

hi('PreProc',   { fg=fg.grey2, bg=nil })
hi('Include',   { link='PreProc' })
hi('Define',    { link='PreProc' })
hi('Macro',     { link='PreProc' })
hi('PreCondit', { link='PreProc' })

hi('Type',         { fg=fg.grey2, bg=nil })
hi('StorageClass', { link='Type' })
hi('Structure',    { link='Type' })
hi('Typedef',      { link='Type' })

hi('Special',        { fg=fg.cyan, bg=nil })
hi('Tag',            { link='Special' })
hi('SpecialChar',    { link='Special' })
hi('Delimiter',      { fg=fg.grey4,      bg=nil })
hi('SpecialComment', { link='Special' })
hi('Debug',          { link='Special' })

hi('LspInlayHint',   { link='NonText' })
hi('SnippetTabstop', { link='Visual'  })

hi('Underlined', { fg=nil,      bg=nil, underline=true })
hi('Ignore',     { link='Normal' })
hi('Error',      { fg=bg.grey1, bg=fg.red })
hi('Todo',       { fg=fg.grey1, bg=nil, bold=true })

hi('diffAdded',   { fg=fg.green, bg=nil })
hi('diffRemoved', { fg=fg.red,   bg=nil })

-- Built-in diagnostic
hi('DiagnosticError', { fg=fg.red,    bg=nil })
hi('DiagnosticWarn',  { fg=fg.yellow, bg=nil })
hi('DiagnosticInfo',  { fg=fg.cyan,   bg=nil })
hi('DiagnosticHint',  { fg=fg.blue,   bg=nil })
hi('DiagnosticOk',    { fg=fg.green,  bg=nil })

hi('DiagnosticUnderlineError', { fg=nil, bg=nil, sp=fg.red,    underline=true })
hi('DiagnosticUnderlineWarn',  { fg=nil, bg=nil, sp=fg.yellow, underline=true })
hi('DiagnosticUnderlineInfo',  { fg=nil, bg=nil, sp=fg.cyan,   underline=true })
hi('DiagnosticUnderlineHint',  { fg=nil, bg=nil, sp=fg.blue,   underline=true })
hi('DiagnosticUnderlineOk',    { fg=nil, bg=nil, sp=fg.green,  underline=true })

hi('DiagnosticFloatingError', { fg=fg.red,    bg=bg.grey1 })
hi('DiagnosticFloatingWarn',  { fg=fg.yellow, bg=bg.grey1 })
hi('DiagnosticFloatingInfo',  { fg=fg.cyan,   bg=bg.grey1 })
hi('DiagnosticFloatingHint',  { fg=fg.blue,   bg=bg.grey1 })
hi('DiagnosticFloatingOk',    { fg=fg.green,  bg=bg.grey1 })

hi('DiagnosticVirtualTextError', { link='DiagnosticError' })
hi('DiagnosticVirtualTextWarn',  { link='DiagnosticWarn' })
hi('DiagnosticVirtualTextInfo',  { link='DiagnosticInfo' })
hi('DiagnosticVirtualTextHint',  { link='DiagnosticHint' })
hi('DiagnosticVirtualTextOk',    { link='DiagnosticOk' })

hi('DiagnosticSignError', { link='DiagnosticError' })
hi('DiagnosticSignWarn',  { link='DiagnosticWarn' })
hi('DiagnosticSignInfo',  { link='DiagnosticInfo' })
hi('DiagnosticSignHint',  { link='DiagnosticHint' })
hi('DiagnosticSignOk',    { link='DiagnosticOk' })

hi('DiagnosticDeprecated',  { fg=nil, bg=nil, sp=fg.red, strikethrough=true })
hi('DiagnosticUnnecessary', { link='Comment' })

-- Tree-sitter
-- - Text
hi('@text.literal',   { link='Comment' })
hi('@text.reference', { link='Identifier' })
hi('@text.title',     { link='Title' })
hi('@text.uri',       { link='Underlined' })
hi('@text.underline', { link='Underlined' })
hi('@text.todo',      { link='Todo' })

-- - Miscs
hi('@comment',     { link='Comment' })
hi('@punctuation', { link='Delimiter' })

-- - Constants
hi('@constant',          { link='Constant' })
hi('@constant.builtin',  { link='Special' })
hi('@constant.macro',    { link='Define' })
hi('@define',            { link='Define' })
hi('@macro',             { link='Macro' })
hi('@string',            { link='String' })
hi('@string.escape',     { link='SpecialChar' })
hi('@string.special',    { link='SpecialChar' })
hi('@character',         { link='Character' })
hi('@character.special', { link='SpecialChar' })
hi('@number',            { link='Number' })
hi('@boolean',           { link='Boolean' })
hi('@float',             { link='Float' })

-- - Functions
hi('@function',         { link='Function' })
hi('@function.builtin', { link='Special' })
hi('@function.macro',   { link='Macro' })
hi('@parameter',        { link='Identifier' })
hi('@method',           { link='Function' })
hi('@field',            { link='Identifier' })
-- hi('@property',         { link='Identifier' })
hi('@property',         { fg=fg.blue, bg=nil })
hi('@constructor',      { link='Special' })

-- - Keywords
hi('@conditional', { link='Conditional' })
hi('@repeat',      { link='Repeat' })
hi('@label',       { link='Label' })
hi('@operator',    { link='Operator' })
hi('@keyword',     { link='Keyword' })
hi('@exception',   { link='Exception' })

hi('@variable',        { fg=fg.grey3, bg=nil }) -- using default foreground reduces visual overload
hi('@type',            { link='Type' })
hi('@type.definition', { link='Typedef' })
hi('@storageclass',    { link='StorageClass' })
hi('@namespace',       { link='Identifier' })
hi('@include',         { link='Include' })
hi('@preproc',         { link='PreProc' })
hi('@debug',           { link='Debug' })
hi('@tag',             { link='Tag' })

-- - LSP semantic tokens
hi('@lsp.type.class',         { link='Structure' })
hi('@lsp.type.comment',       { link='Comment' })
hi('@lsp.type.decorator',     { link='Function' })
hi('@lsp.type.enum',          { link='Structure' })
hi('@lsp.type.enumMember',    { link='Constant' })
hi('@lsp.type.function',      { link='Function' })
hi('@lsp.type.interface',     { link='Structure' })
hi('@lsp.type.macro',         { link='Macro' })
hi('@lsp.type.method',        { link='Function' })
hi('@lsp.type.namespace',     { link='Structure' })
hi('@lsp.type.parameter',     { link='Identifier' })
hi('@lsp.type.property',      { link='Identifier' })
hi('@lsp.type.struct',        { link='Structure' })
hi('@lsp.type.type',          { link='Type' })
hi('@lsp.type.typeParameter', { link='TypeDef' })
hi('@lsp.type.variable',      { link='@variable' }) -- links to tree-sitter group to reduce overload

-- - TSX
hi('@tag.delimiter.tsx',      { link='Delimiter'})
hi('@constant.builtin.tsx',   { link='Constant'})
hi('@type.builtin.tsx',       { link='Constant'})

-- - HTML
hi('@tag.delimiter.html',     { link='Delimiter'})
hi('@tag.html',               { link='Function'})
hi('@tag.attribute.html',     { link='Identifier'})


-- Blink.cmp
hi('BlinkCmpGhostText', { link='Comment'})

vim.g.terminal_color_0  = bg.grey2
vim.g.terminal_color_1  = fg.red
vim.g.terminal_color_2  = fg.green
vim.g.terminal_color_3  = fg.yellow
vim.g.terminal_color_4  = fg.blue
vim.g.terminal_color_5  = fg.cyan
vim.g.terminal_color_6  = fg.magenta
vim.g.terminal_color_7  = fg.grey2
vim.g.terminal_color_8  = bg.grey2
vim.g.terminal_color_9  = fg.red
vim.g.terminal_color_10 = fg.green
vim.g.terminal_color_11 = fg.yellow
vim.g.terminal_color_12 = fg.blue
vim.g.terminal_color_13 = fg.cyan
vim.g.terminal_color_14 = fg.magenta
vim.g.terminal_color_15 = fg.grey2
