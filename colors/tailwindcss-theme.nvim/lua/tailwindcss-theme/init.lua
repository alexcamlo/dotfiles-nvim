--- tailwindcss-theme.nvim
--- Neovim port of the "tailwindcss-theme" used by tailwindcss.com for its
--- Shiki-highlighted code blocks.
--- Source theme:  https://github.com/tailwindlabs/tailwindcss.com/blob/main/src/components/syntax-highlighter/theme.json
--- Source repo has no LICENSE file (site code, unlicensed); attribution to
--- Tailwind Labs. Palette values resolved from the Tailwind CSS v4 default
--- palette (oklch -> sRGB).
--- Generated 2026-10-30. Dark only: the docs theme defines no light variant.

local M = {}

M.palette = {
  ["amber-200"] = "#fee685",
  ["amber-300"] = "#ffd230",
  ["bg"] = "#10131e",
  ["black"] = "#000000",
  ["blue-200"] = "#bedbff",
  ["blue-300"] = "#8ec5ff",
  ["blue-400"] = "#51a2ff",
  ["blue-500"] = "#2b7fff",
  ["cursorline"] = "#24323e",
  ["cyan-300"] = "#53eafd",
  ["cyan-400"] = "#00d3f2",
  ["diffadd"] = "#0c433b",
  ["diffchange"] = "#172e56",
  ["diffdel"] = "#4c2736",
  ["difftext"] = "#1c4483",
  ["emerald-300"] = "#5ee9b5",
  ["emerald-400"] = "#00d492",
  ["emerald-600"] = "#009966",
  ["errbg"] = "#4c2736",
  ["fold"] = "#101524",
  ["gray-950"] = "#030712",
  ["infobg"] = "#2a4c78",
  ["orange-200"] = "#ffd6a7",
  ["orange-300"] = "#ffb86a",
  ["orange-800"] = "#9f2d00",
  ["orange-900"] = "#7e2a0c",
  ["pink-400"] = "#fb64b6",
  ["purple-300"] = "#dab2ff",
  ["rose-300"] = "#ffa1ad",
  ["rose-400"] = "#ff637e",
  ["rose-700"] = "#c70036",
  ["search"] = "#4f328e",
  ["selection"] = "#444852",
  ["sky-300"] = "#74d4ff",
  ["sky-400"] = "#00bcff",
  ["sky-500"] = "#00a6f4",
  ["sky-900"] = "#024a70",
  ["slate-200"] = "#e2e8f0",
  ["slate-300"] = "#cad5e2",
  ["slate-400"] = "#90a1b9",
  ["slate-50"] = "#f8fafc",
  ["slate-500"] = "#62748e",
  ["slate-600"] = "#45556c",
  ["slate-700"] = "#314158",
  ["slate-800"] = "#1d293d",
  ["slate-900"] = "#0f172b",
  ["teal-100"] = "#cbfbf1",
  ["teal-200"] = "#96f7e4",
  ["violet-300"] = "#c4b4ff",
  ["violet-400"] = "#a684ff",
  ["violet-500"] = "#8e51ff",
  ["warnbg"] = "#4c4322",
  ["white"] = "#ffffff",
  ["wordhl"] = "#252833",
}

M.config = {
  transparent = false, -- editor.background is "transparent" in the source theme
  italic_comments = true, -- comments are italic on tailwindcss.com
}

function M.setup(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

local function apply()
  local c = M.palette
  local cfg = M.config
  local bg = cfg.transparent and "NONE" or c.bg

  local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end
  local function link(group, target)
    vim.api.nvim_set_hl(0, group, { link = target })
  end

  ---------------------------------------------------------------
  -- Editor UI (adapted from the theme.json "colors" section)
  ---------------------------------------------------------------
  hi("Normal", { fg = c["slate-50"], bg = bg })            -- editor.foreground
  hi("NormalNC", { fg = c["slate-50"], bg = bg })
  hi("NormalFloat", { fg = c["slate-300"], bg = c["slate-800"] })
  hi("FloatBorder", { fg = c["slate-600"], bg = c["slate-800"] })
  hi("FloatTitle", { fg = c["slate-200"], bg = c["slate-800"] })
  hi("Pmenu", { fg = c["slate-300"], bg = c["slate-800"] })
  hi("PmenuSel", { fg = c["slate-50"], bg = c.selection })
  hi("PmenuSbar", { bg = c["slate-800"] })
  hi("PmenuThumb", { bg = c["slate-500"] })
  hi("PmenuKind", { fg = c["violet-300"], bg = c["slate-800"] })
  hi("PmenuKindSel", { fg = c["violet-300"], bg = c.selection })
  hi("PmenuExtra", { fg = c["slate-400"], bg = c["slate-800"] })
  hi("PmenuExtraSel", { fg = c["slate-300"], bg = c.selection })
  hi("WildMenu", { fg = c["slate-900"], bg = c["sky-500"] })

  hi("Cursor", { fg = c.bg, bg = c["slate-50"] })          -- editorCursor.foreground
  hi("lCursor", { fg = c.bg, bg = c["slate-50"] })
  hi("CursorLine", { bg = cfg.transparent and "NONE" or c.cursorline })
  hi("CursorColumn", { bg = cfg.transparent and "NONE" or c.cursorline })
  hi("CursorLineNr", { fg = c["slate-200"], bold = true }) -- editorLineNumber.activeForeground
  hi("LineNr", { fg = c["slate-500"] })                    -- editorLineNumber.foreground
  hi("SignColumn", { fg = c["slate-500"], bg = bg })
  hi("ColorColumn", { bg = cfg.transparent and "NONE" or c["slate-800"] })

  hi("Visual", { bg = c.selection })                       -- editor.selectionBackground
  hi("VisualNOS", { bg = c.selection })
  hi("Search", { bg = c.search })                          -- editor.findMatchBackground
  hi("IncSearch", { fg = c["slate-900"], bg = c["violet-400"] })
  hi("CurSearch", { fg = c["slate-900"], bg = c["violet-400"] })
  hi("Substitute", { fg = c["slate-900"], bg = c["rose-400"] })
  hi("MatchParen", { bg = c.selection, bold = true })

  hi("StatusLine", { fg = c["slate-300"], bg = c["slate-800"] })
  hi("StatusLineNC", { fg = c["slate-500"], bg = cfg.transparent and "NONE" or c.fold })
  hi("TabLine", { fg = c["slate-400"], bg = c["slate-800"] })
  hi("TabLineSel", { fg = c["slate-200"], bg = bg, bold = true })
  hi("TabLineFill", { bg = cfg.transparent and "NONE" or c["slate-800"] })
  hi("WinBar", { fg = c["slate-300"], bg = bg })
  hi("WinBarNC", { fg = c["slate-500"], bg = bg })
  hi("WinSeparator", { fg = c["slate-700"], bg = bg })     -- titleBar.border

  hi("Folded", { fg = c["slate-400"], bg = cfg.transparent and "NONE" or c.fold })
  hi("FoldColumn", { fg = c["slate-500"], bg = bg })
  hi("NonText", { fg = c["slate-600"] })
  hi("SpecialKey", { fg = c["slate-600"] })
  hi("Whitespace", { fg = cfg.transparent and c["slate-700"] or c.wordhl })
  hi("EndOfBuffer", { fg = c["slate-700"] })
  hi("Conceal", { fg = c["slate-400"] })
  hi("Directory", { fg = c["sky-400"] })
  hi("Title", { fg = c["slate-200"], bold = true })
  hi("Question", { fg = c["sky-400"] })
  hi("MoreMsg", { fg = c["sky-400"] })
  hi("ModeMsg", { fg = c["slate-300"] })
  hi("ErrorMsg", { fg = c["rose-400"] })
  hi("WarningMsg", { fg = c["amber-300"] })
  hi("QuickFixLine", { bg = c.selection })

  ---------------------------------------------------------------
  -- Diagnostics / git (theme.json "colors": editorError, editorGutter, diff)
  ---------------------------------------------------------------
  hi("DiagnosticError", { fg = c["rose-400"] })
  hi("DiagnosticWarn", { fg = c["amber-300"] })
  hi("DiagnosticInfo", { fg = c["blue-400"] })
  hi("DiagnosticHint", { fg = c["blue-400"] })
  hi("DiagnosticOk", { fg = c["emerald-400"] })
  hi("DiagnosticUnderlineError", { undercurl = true, sp = c["rose-400"] })
  hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c["amber-300"] })
  hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c["blue-400"] })
  hi("DiagnosticUnderlineHint", { undercurl = true, sp = c["blue-400"] })
  hi("DiagnosticVirtualTextError", { fg = c["rose-400"], bg = cfg.transparent and "NONE" or c.errbg })
  hi("DiagnosticVirtualTextWarn", { fg = c["amber-300"], bg = cfg.transparent and "NONE" or c.warnbg })
  hi("DiagnosticVirtualTextInfo", { fg = c["blue-400"], bg = cfg.transparent and "NONE" or c.infobg })
  hi("DiagnosticVirtualTextHint", { fg = c["blue-400"] })
  hi("DiagnosticFloatingError", { fg = c["rose-400"] })
  hi("DiagnosticFloatingWarn", { fg = c["amber-300"] })
  hi("DiagnosticFloatingInfo", { fg = c["blue-400"] })
  hi("DiagnosticFloatingHint", { fg = c["blue-400"] })
  hi("DiagnosticSignError", { fg = c["rose-400"], bg = bg })
  hi("DiagnosticSignWarn", { fg = c["amber-300"], bg = bg })
  hi("DiagnosticSignInfo", { fg = c["blue-400"], bg = bg })
  hi("DiagnosticSignHint", { fg = c["blue-400"], bg = bg })

  hi("Added", { fg = c["emerald-400"] })                   -- editorGutter.addedBackground
  hi("Removed", { fg = c["rose-400"] })                    -- editorGutter.deletedBackground
  hi("Changed", { fg = c["blue-400"] })                    -- editorGutter.modifiedBackground
  hi("DiffAdd", { bg = cfg.transparent and "NONE" or c.diffadd })
  hi("DiffDelete", { bg = cfg.transparent and "NONE" or c.diffdel })
  hi("DiffChange", { bg = cfg.transparent and "NONE" or c.diffchange })
  hi("DiffText", { bg = cfg.transparent and "NONE" or c.difftext })
  hi("diffAdded", { fg = c["emerald-400"] })
  hi("diffRemoved", { fg = c["rose-400"] })
  hi("diffChanged", { fg = c["blue-400"] })

  hi("SpellBad", { undercurl = true, sp = c["rose-400"] })
  hi("SpellCap", { undercurl = true, sp = c["amber-300"] })
  hi("SpellLocal", { undercurl = true, sp = c["blue-400"] })
  hi("SpellRare", { undercurl = true, sp = c["violet-400"] })

  ---------------------------------------------------------------
  -- Syntax (adapted from theme.json "tokenColors")
  ---------------------------------------------------------------
  hi("Comment", { fg = c["slate-400"], italic = cfg.italic_comments })

  hi("Constant", { fg = c["amber-200"] })                  -- constant
  hi("String", { fg = c["sky-300"] })                      -- string
  hi("Character", { fg = c["sky-300"] })
  hi("Number", { fg = c["amber-200"] })
  hi("Boolean", { fg = c["amber-200"] })
  hi("Float", { fg = c["amber-200"] })

  hi("Identifier", { fg = c["rose-300"] })                 -- variable
  hi("Function", { fg = c["teal-200"] })                   -- entity.name.function

  hi("Statement", { fg = c["violet-300"] })                -- keyword
  hi("Conditional", { fg = c["violet-300"] })
  hi("Repeat", { fg = c["violet-300"] })
  hi("Label", { fg = c["violet-300"] })
  hi("Operator", { fg = c["violet-300"] })
  hi("Keyword", { fg = c["violet-300"] })
  hi("Exception", { fg = c["violet-300"] })

  hi("PreProc", { fg = c["slate-300"] })                   -- storage / import
  hi("Include", { fg = c["slate-300"] })
  hi("Define", { fg = c["slate-300"] })
  hi("Macro", { fg = c["slate-300"] })
  hi("PreCondit", { fg = c["violet-300"] })

  hi("Type", { fg = c["slate-300"] })                      -- entity
  hi("StorageClass", { fg = c["slate-300"] })
  hi("Structure", { fg = c["slate-300"] })
  hi("Typedef", { fg = c["slate-300"] })

  hi("Special", { fg = c["violet-300"] })                  -- support
  hi("SpecialChar", { fg = c["slate-300"] })               -- constant.character.escape
  hi("Tag", { fg = c["pink-400"] })                        -- entity.name(.tag)
  hi("Delimiter", { fg = c["slate-400"] })                 -- punctuation
  hi("SpecialComment", { fg = c["slate-400"], italic = cfg.italic_comments })
  hi("Debug", { fg = c["rose-400"] })

  hi("Underlined", { fg = c["sky-400"], underline = true })
  hi("Ignore", { fg = c["slate-500"] })
  hi("Error", { fg = c["rose-400"] })
  hi("Todo", { fg = c["amber-300"], bold = true })

  ---------------------------------------------------------------
  -- Treesitter captures
  ---------------------------------------------------------------
  link("@comment", "Comment")
  hi("@comment.todo", { fg = c["amber-300"], bold = true })
  hi("@comment.error", { fg = c["rose-400"], bold = true })
  hi("@comment.warning", { fg = c["amber-300"], bold = true })
  hi("@comment.note", { fg = c["blue-400"], bold = true })

  hi("@punctuation", { fg = c["slate-400"] })
  hi("@punctuation.delimiter", { fg = c["slate-400"] })
  hi("@punctuation.bracket", { fg = c["slate-400"] })
  hi("@punctuation.special", { fg = c["slate-400"] })

  hi("@string", { fg = c["sky-300"] })
  hi("@string.documentation", { fg = c["sky-300"] })
  hi("@string.regex", { fg = c["sky-300"] })
  hi("@string.escape", { fg = c["slate-300"] })
  hi("@string.special", { fg = c["sky-300"] })
  hi("@string.special.url", { fg = c["sky-400"], underline = true })
  hi("@character", { fg = c["sky-300"] })

  hi("@constant", { fg = c["amber-200"] })
  hi("@constant.builtin", { fg = c["violet-300"] })
  hi("@constant.macro", { fg = c["amber-200"] })
  hi("@number", { fg = c["amber-200"] })
  hi("@number.float", { fg = c["amber-200"] })
  hi("@boolean", { fg = c["amber-200"] })

  hi("@keyword", { fg = c["violet-300"] })
  hi("@keyword.function", { fg = c["violet-300"] })
  hi("@keyword.operator", { fg = c["violet-300"] })
  hi("@keyword.return", { fg = c["violet-300"] })
  hi("@keyword.conditional", { fg = c["violet-300"] })
  hi("@keyword.repeat", { fg = c["violet-300"] })
  hi("@keyword.exception", { fg = c["violet-300"] })
  hi("@keyword.import", { fg = c["slate-300"] })           -- [JS] Import
  hi("@keyword.directive", { fg = c["slate-300"] })
  hi("@operator", { fg = c["violet-300"] })

  hi("@function", { fg = c["teal-200"] })
  hi("@function.call", { fg = c["teal-200"] })
  hi("@function.builtin", { fg = c["teal-200"] })
  hi("@function.macro", { fg = c["slate-300"] })
  hi("@constructor", { fg = c["slate-300"] })

  hi("@type", { fg = c["slate-300"] })
  hi("@type.builtin", { fg = c["slate-300"] })
  hi("@type.definition", { fg = c["slate-300"] })
  hi("@attribute", { fg = c["slate-300"] })
  hi("@module", { fg = c["violet-300"] })                  -- support
  hi("@label", { fg = c["violet-300"] })

  hi("@variable", { fg = c["rose-300"] })                  -- variable
  hi("@variable.builtin", { fg = c["rose-300"], italic = cfg.italic_comments })
  hi("@variable.parameter", { fg = c["rose-300"] })
  hi("@variable.member", { fg = c["slate-300"] })          -- variable.other.property
  hi("@property", { fg = c["slate-300"] })

  hi("@tag", { fg = c["pink-400"] })                       -- [HTML] entity
  hi("@tag.attribute", { fg = c["slate-300"] })            -- [HTML] attribute names
  hi("@tag.delimiter", { fg = c["slate-400"] })            -- [HTML] punctuation
  hi("@tag.builtin", { fg = c["pink-400"] })

  -- markup
  hi("@markup.heading", { fg = c["slate-200"], bold = true })
  hi("@markup.link", { fg = c["violet-300"] })
  hi("@markup.link.label", { fg = c["sky-300"] })
  hi("@markup.link.url", { fg = c["sky-400"], underline = true })
  hi("@markup.raw", { fg = c["sky-300"] })
  hi("@markup.quote", { fg = c["slate-400"], italic = cfg.italic_comments })
  hi("@markup.list", { fg = c["slate-400"] })
  hi("@markup.strong", { bold = true })
  hi("@markup.italic", { italic = true })
  hi("@markup.strikethrough", { strikethrough = true })

  hi("@diff.plus", { fg = c["emerald-400"] })
  hi("@diff.minus", { fg = c["rose-400"] })
  hi("@diff.delta", { fg = c["blue-400"] })

  ---------------------------------------------------------------
  -- Language-specific rules carried over from theme.json
  ---------------------------------------------------------------
  -- CSS: property names sky-300, selectors pink-400, values slate-50,
  -- units teal-100, functions blue-200, custom properties teal-200,
  -- attribute selectors violet-300, at-rules slate-300
  hi("@property.css", { fg = c["sky-300"] })
  hi("@type.css", { fg = c["pink-400"] })
  hi("@tag.css", { fg = c["pink-400"] })
  hi("@string.css", { fg = c["sky-300"] })
  hi("@string.plain.css", { fg = c["slate-50"] })
  hi("@constant.css", { fg = c["slate-50"] })
  hi("@number.css", { fg = c["slate-50"] })
  hi("@number.float.css", { fg = c["slate-50"] })
  hi("@function.css", { fg = c["blue-200"] })
  hi("@function.call.css", { fg = c["blue-200"] })
  hi("@variable.css", { fg = c["teal-200"] })
  hi("@attribute.css", { fg = c["violet-300"] })
  hi("@keyword.css", { fg = c["slate-300"] })
  hi("@keyword.import.css", { fg = c["slate-300"] })
  hi("@punctuation.delimiter.css", { fg = c["slate-300"] })
  hi("@punctuation.bracket.css", { fg = c["slate-300"] })
  hi("@operator.css", { fg = c["slate-300"] })

  -- HTML: doctype rendered at 75% blue-300 on the site
  hi("@constant.html", { fg = c["blue-300"] })
  hi("@string.html", { fg = c["sky-300"] })

  -- JSON: keys slate-200, scalar constants rose-300
  hi("@property.json", { fg = c["slate-200"] })
  hi("@label.json", { fg = c["slate-200"] })
  hi("@constant.json", { fg = c["rose-300"] })
  hi("@boolean.json", { fg = c["rose-300"] })
  hi("@number.json", { fg = c["rose-300"] })

  ---------------------------------------------------------------
  -- LSP semantic tokens: fall back to treesitter, small overrides only
  ---------------------------------------------------------------
  link("@lsp.type.comment", "@comment")
  link("@lsp.type.string", "@string")
  link("@lsp.type.number", "@number")
  link("@lsp.type.keyword", "@keyword")
  link("@lsp.type.operator", "@operator")
  link("@lsp.type.function", "@function")
  link("@lsp.type.method", "@function")
  link("@lsp.type.macro", "@function.macro")
  link("@lsp.type.type", "@type")
  link("@lsp.type.class", "@type")
  link("@lsp.type.interface", "@type")
  link("@lsp.type.enum", "@type")
  link("@lsp.type.namespace", "@module")
  link("@lsp.type.parameter", "@variable.parameter")
  link("@lsp.type.variable", "@variable")
  link("@lsp.type.property", "@property")
  link("@lsp.type.enumMember", "@constant")
  link("@lsp.type.decorator", "@attribute")

  ---------------------------------------------------------------
  -- Plugins (small set, mapped to the same palette)
  ---------------------------------------------------------------
  -- gitsigns
  link("GitSignsAdd", "Added")
  link("GitSignsChange", "Changed")
  link("GitSignsDelete", "Removed")
  -- telescope
  hi("TelescopeNormal", { fg = c["slate-300"], bg = c["slate-800"] })
  hi("TelescopeBorder", { fg = c["slate-600"], bg = c["slate-800"] })
  hi("TelescopeSelection", { bg = c.selection })
  hi("TelescopeMatching", { fg = c["sky-300"], bold = true })
  hi("TelescopePromptPrefix", { fg = c["sky-400"] })
  -- nvim-tree / neo-tree
  hi("NvimTreeNormal", { fg = c["slate-300"], bg = cfg.transparent and "NONE" or c.fold })
  hi("NvimTreeFolderName", { fg = c["slate-300"] })
  hi("NvimTreeOpenedFolderName", { fg = c["slate-200"], bold = true })
  hi("NvimTreeRootFolder", { fg = c["sky-400"], bold = true })
  hi("NvimTreeGitDirty", { fg = c["blue-400"] })
  hi("NvimTreeGitNew", { fg = c["emerald-400"] })
  hi("NvimTreeGitDeleted", { fg = c["rose-400"] })
  -- indent-blankline
  hi("IblIndent", { fg = cfg.transparent and c["slate-800"] or c.wordhl })
  hi("IblScope", { fg = c["slate-500"] })
  -- which-key
  hi("WhichKey", { fg = c["sky-300"] })
  hi("WhichKeyGroup", { fg = c["violet-300"] })
  hi("WhichKeyDesc", { fg = c["slate-300"] })
  hi("WhichKeySeparator", { fg = c["slate-500"] })
  -- notify
  hi("NotifyERRORBorder", { fg = c["rose-400"] })
  hi("NotifyWARNBorder", { fg = c["amber-300"] })
  hi("NotifyINFOBorder", { fg = c["blue-400"] })
  hi("NotifyERRORTitle", { fg = c["rose-400"] })
  hi("NotifyWARNTitle", { fg = c["amber-300"] })
  hi("NotifyINFOTitle", { fg = c["blue-400"] })

  ---------------------------------------------------------------
  -- Legacy Vim syntax fallbacks (no treesitter): same palette,
  -- applied to each filetype's own highlight groups
  ---------------------------------------------------------------
  -- HTML / XML / JSX
  hi("htmlTag", { fg = c["slate-400"] })
  hi("htmlEndTag", { fg = c["slate-400"] })
  hi("htmlTagName", { fg = c["pink-400"] })
  hi("htmlTagN", { fg = c["pink-400"] })
  hi("htmlArg", { fg = c["slate-300"] })
  hi("htmlString", { fg = c["sky-300"] })
  hi("htmlPreProc", { fg = c["blue-300"] })                -- doctype
  link("htmlComment", "Comment")
  link("htmlCommentPart", "Comment")
  hi("xmlTag", { fg = c["slate-400"] })
  hi("xmlEndTag", { fg = c["slate-400"] })
  hi("xmlTagName", { fg = c["pink-400"] })
  hi("xmlAttrib", { fg = c["slate-300"] })
  hi("xmlString", { fg = c["sky-300"] })

  -- CSS (legacy syntax): selectors pink-400, property names sky-300,
  -- values slate-50, units teal-100, functions blue-200,
  -- custom properties teal-200, at-rules slate-300, colors amber-200
  hi("cssTagName", { fg = c["pink-400"] })
  hi("cssClassName", { fg = c["pink-400"] })
  hi("cssClassNameDot", { fg = c["pink-400"] })
  hi("cssIdentifier", { fg = c["pink-400"] })
  hi("cssPseudoClassId", { fg = c["pink-400"] })
  hi("cssProp", { fg = c["sky-300"] })
  hi("cssVendor", { fg = c["sky-300"] })
  hi("cssValueNumber", { fg = c["slate-50"] })
  hi("cssValueInteger", { fg = c["slate-50"] })
  hi("cssValueLength", { fg = c["slate-50"] })
  hi("cssValueAngle", { fg = c["slate-50"] })
  hi("cssValueTime", { fg = c["slate-50"] })
  hi("cssUnitDecorators", { fg = c["teal-100"] })
  hi("cssFunction", { fg = c["blue-200"] })
  hi("cssFunctionName", { fg = c["blue-200"] })
  hi("cssCustomProp", { fg = c["teal-200"] })
  hi("cssAtRule", { fg = c["slate-300"] })
  hi("cssAtKeyword", { fg = c["slate-300"] })
  hi("cssAtRuleLogical", { fg = c["slate-300"] })
  hi("cssBraces", { fg = c["slate-300"] })
  hi("cssNoise", { fg = c["slate-300"] })
  hi("cssAttributeSelector", { fg = c["violet-300"] })
  hi("cssStringQ", { fg = c["sky-300"] })
  hi("cssStringQQ", { fg = c["sky-300"] })
  hi("cssColor", { fg = c["amber-200"] })
  hi("cssImportant", { fg = c["violet-300"] })

  -- JSON (legacy syntax)
  hi("jsonKeyword", { fg = c["slate-200"] })
  hi("jsonString", { fg = c["sky-300"] })
  hi("jsonNumber", { fg = c["rose-300"] })
  hi("jsonBoolean", { fg = c["rose-300"] })
  hi("jsonNull", { fg = c["rose-300"] })
  hi("jsonBraces", { fg = c["slate-400"] })

  -- Shell (generic coverage, same palette)
  hi("shDeref", { fg = c["rose-300"] })
  hi("shDerefSimple", { fg = c["rose-300"] })
  hi("shVariable", { fg = c["rose-300"] })
  hi("shFunction", { fg = c["teal-200"] })
  hi("shCommandSub", { fg = c["slate-50"] })
  hi("shQuote", { fg = c["sky-300"] })

  ---------------------------------------------------------------
  -- Terminal colors (theme.json terminal.ansi*)
  ---------------------------------------------------------------
  vim.g.terminal_color_0  = c["slate-800"]
  vim.g.terminal_color_1  = c["rose-400"]
  vim.g.terminal_color_2  = c["emerald-400"]
  vim.g.terminal_color_3  = c["amber-300"]
  vim.g.terminal_color_4  = c["blue-500"]
  vim.g.terminal_color_5  = c["violet-400"]
  vim.g.terminal_color_6  = c["cyan-400"]
  vim.g.terminal_color_7  = c["slate-300"]
  vim.g.terminal_color_8  = c["slate-400"]
  vim.g.terminal_color_9  = c["rose-400"]
  vim.g.terminal_color_10 = c["emerald-300"]
  vim.g.terminal_color_11 = c["amber-300"]
  vim.g.terminal_color_12 = c["blue-400"]
  vim.g.terminal_color_13 = c["purple-300"]
  vim.g.terminal_color_14 = c["cyan-300"]
  vim.g.terminal_color_15 = c["white"]
end

function M.load()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "tailwindcss-theme"
  apply()
end

return M
