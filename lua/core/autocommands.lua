-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("UserAlphaStatus", { clear = true }),
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd([[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]])
  end,
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserBufferCloseQ", { clear = true }),
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- show cursor line only in active window
local cursorline_group = vim.api.nvim_create_augroup("UserAutoCursorline", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = cursorline_group,
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = cursorline_group,
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("UserFormatOptions", { clear = true }),
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("UserBaseHighlights", { clear = true }),
  callback = function()
    vim.cmd([[
      hi link illuminatedWord LspReferenceText
      hi! Normal ctermbg=NONE guibg=NONE
      hi! Nontext ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
      hi Comment cterm=italic gui=italic
      hi htmlArg cterm=italic gui=italic
      hi CursorLine cterm=none ctermbg=234 ctermfg=none
    ]])
  end,
})

-- Stay Centered
-- Off by default to avoid jank. Enable with: vim.g.stay_centered = true
vim.g.stay_centered = vim.g.stay_centered or false

local function stay_centered_insert()
  if not vim.g.stay_centered then
    return
  end
  local line = vim.fn.line(".")
  local last_line = vim.b.last_line or 0

  if line ~= last_line then
    local col = vim.fn.getcurpos()[4]
    vim.cmd("normal! zz")
    vim.fn.cursor(line, col)
    vim.b.last_line = line
  end
end

local function stay_centered()
  if not vim.g.stay_centered then
    return
  end
  local line = vim.fn.line(".")
  local last_line = vim.b.last_line or 0

  if line ~= last_line then
    vim.cmd("normal! zz")
    vim.b.last_line = line
  end
end

-- Stay Centered autocommands
local stay_centered_group = vim.api.nvim_create_augroup("StayCentered", { clear = true })
vim.api.nvim_create_autocmd("CursorMovedI", {
  group = stay_centered_group,
  callback = stay_centered_insert,
})
vim.api.nvim_create_autocmd("CursorMoved", {
  group = stay_centered_group,
  callback = stay_centered,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("UserYankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Diagnostic float on CursorHold.
-- Off by default to avoid flicker/jank. Enable with: vim.g.diagnostic_float = true
vim.g.diagnostic_float = vim.g.diagnostic_float or false

vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("UserDiagnosticFloat", { clear = true }),
  pattern = "*",
  callback = function()
    if not vim.g.diagnostic_float then
      return
    end
    for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
      if vim.api.nvim_win_get_config(winid).zindex then
        return
      end
    end
    vim.diagnostic.open_float({
      scope = "cursor",
      focusable = false,
      close_events = {
        "CursorMoved",
        "CursorMovedI",
        "BufHidden",
        "InsertCharPre",
        "WinLeave",
      },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserCsvView", { clear = true }),
  pattern = "csv",
  desc = "Enable CSV View on .csv files",
  callback = function()
    require("csvview").enable()
  end,
})
-- Overwrite highlight groups in any colorscheme
-- vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
--   group = vim.api.nvim_create_augroup("Color", {}),
--   pattern = "*",
--   callback = function()
--     local comment = "#71717a"
--
--     local hl = vim.api.nvim_set_hl
--
--     -- hl(0, "String", { fg = foreground })
--     -- hl(0, "Normal", { bg = "none" })
--     -- hl(0, "NormalFloat", { bg = "none" })
--     --
--     -- hl(0, "SignColumn", { fg = "NONE", bg = "none" })
--     -- hl(0, "Comment", { fg = comment, italic = true })
--     -- hl(0, "CursorLine", { bg = dark })
--     -- hl(0, "WhiteSpace", { fg = dark, bg = base10 })
--     -- hl(0, "Visual", { link = "IncSearch" })
--     -- hl(0, "@function", { bold = false })
--     -- hl(0, "CursorLine", { fg = "NONE", bg = dark })
--     -- hl(0, "CursorLineNr", { fg = gray_light, bg = "NONE", bold = true })
--     -- hl(0, "LineNr", { fg = comment, bg = "NONE" })
--   end,
-- })
