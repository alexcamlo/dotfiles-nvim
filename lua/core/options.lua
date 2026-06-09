-- Aliases
-- local cmd = vim.cmd
local opt = vim.opt

-- Disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Appearance
opt.background = "dark"
opt.termguicolors = true
vim.g.skip_ts_context_commentstring_module = true
opt.showtabline = 1 -- Line above window with file path
opt.pumheight = 10 -- pop up menu height
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
if vim.fn.has("nvim-0.12") == 1 then
  pcall(function()
    require("vim._core.ui2").enable()
  end)
end
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.numberwidth = 4 -- set number column width to 2 {default 4}
opt.showmatch = true -- Show matching parents, brackets, etc.
opt.title = true -- Show title in terminal tab
opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
opt.guicursor = "n-c-sm:block,i-ci-ve:ver25,v-r-cr-o:hor20"
opt.laststatus = 3 -- something for avante

-- Files and Others
-- opt.fileencoding = "utf-8" -- the encoding written to a file
opt.shortmess:append("c")
opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("_")

-- Split Windows
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window

-- Updates and Backups
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.backup = false -- creates a backup file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.updatetime = 500 -- faster completion (4000ms default); 500ms keeps CPU reasonable while staying responsive
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.swapfile = false -- creates a swapfile
opt.undofile = true -- enable persistent undo
opt.autoread = true

-- clipboard
opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

-- Backspace key

-- Search
opt.hlsearch = true -- Don't highlight all matches on previous search pattern (In previous config it was false)
opt.incsearch = true -- show highlight while writing search
opt.inccommand = "split" -- Shows the match while typing
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- smart case

-- Mouse and Scrolling
opt.scrolloff = 8 -- is one of my fav
opt.sidescroll = 1 -- Scroll sideways a  character at a time instead of a screen at a time
opt.sidescrolloff = 8
opt.mouse = "a" -- allow the mouse to be used in neovim

-- Wrapping
opt.wrap = true -- display lines as not one long line
opt.breakindent = true
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.cursorline = true -- highlight the current line
opt.signcolumn = "yes:1" -- always show the sign column, otherwise it would shift the text each time
opt.statuscolumn = "%l%s"

-- Tabs and Indentations
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.softtabstop = 2 -- number of tabs when inserting operations
opt.smartindent = true -- make indenting smarter again
opt.expandtab = true -- convert tabs to spaces
-- vim.g.editorconfig = false

-- Others
vim.o.winborder = "rounded"
opt.fillchars.fold = " "
opt.fillchars.eob = " " -- To stop showing ~ at the end of buffer
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Triger `autoread` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
-- Keep this off the high-frequency CursorHold/CursorHoldI events to avoid
-- running `checktime` on every idle beat.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "WinEnter" }, {
  group = vim.api.nvim_create_augroup("UserAutoChecktime", { clear = true }),
  pattern = "*",
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
})

-- Notification after file change
-- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
vim.api.nvim_create_autocmd({ "FileChangedShellPost" }, {
  pattern = "*",
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})
