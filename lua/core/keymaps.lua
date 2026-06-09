-- Shorten function name
local keymap = vim.keymap.set
local cmd = vim.cmd

-- Close floating windows when pressing escape.
local function close_floating()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

keymap("n", "<esc>", function()
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

keymap("i", "<A-BS>", "<C-W>", { desc = "Option+BS deletes whole word" })

--Remap space as leader key
keymap("", "<Space>", "<Nop>", { desc = "Disable space key default behavior" })
vim.g.mapleader = " " -- Set space as the leader key
vim.g.maplocalleader = " " -- Set space as the local leader key
vim.g.have_nerd_font = true -- Enable nerd font support

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

keymap("n", "<Leader>re", "<cmd>restart<cr>", { desc = "Restart Neovim (:restart)" })

keymap("n", ";", ":", { desc = "Map semicolon to colon for easier command mode access" })

keymap("n", "q:", "<nop>", { desc = "Disable command history window" })

-- Better window navigation
keymap("n", "<C-h>", ":wincmd h<CR>", { desc = "Move to left window" })
keymap("n", "<C-j>", ":wincmd j<CR>", { desc = "Move to window below" })
keymap("n", "<C-k>", ":wincmd k<CR>", { desc = "Move to window above" })
keymap("n", "<C-l>", ":wincmd l<CR>", { desc = "Move to right window" })

-- Shortcuts for opening explorer in new splits
keymap("n", "<Leader>ev", ":Vex!<CR>", { desc = "Open vertical split explorer on right" })
keymap("n", "<Leader>es", ":Sex<CR>", { desc = "Open horizontal split explorer above" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Navigate buffers - Removed in favor of harpoon
keymap("n", "<S-l>", ":bnext<CR>", { desc = "Go to next buffer" })
keymap("n", "<Tab>", ":bnext<CR>", { desc = "Go to next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { desc = "Go to previous buffer" })
keymap("n", "<S-Tab>", ":bprevious<CR>", { desc = "Go to previous buffer" })
keymap("n", "<leader>x", function()
  local ok, snacks = pcall(require, "snacks")
  if ok and snacks.bufdelete then
    snacks.bufdelete()
  else
    vim.cmd.bdelete()
  end
end, { desc = "Close current buffer" })
keymap("n", "<leader>bb", "<c-^><cr>", { desc = "Switch to last buffer" })

-- Keeping the cursor center lined when searching
keymap("n", "n", "nzzzv", { desc = "Next search result and center screen" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result and center screen" })

keymap("n", "G", "Gzz", { desc = "Go to end of file and center screen" })

keymap("n", "gh", "^", { desc = "Go to start of line" })
keymap("n", "gl", "$", { desc = "Go to end of line" })

keymap("v", "p", '"_dP', { desc = "Paste over selection without yanking" })
keymap("n", "<Leader>p", "oq<BS><Esc>p", { desc = "Paste on next line" })
keymap("n", "<Leader>P", "Oq<BS><Esc>p", { desc = "Paste on previous line" })

keymap("n", "yc", "yygccp", { desc = "Yank, comment and paste line" })
keymap("n", "Y", "y$", { desc = "Yank to the end" })
-- keymap("n", "yy", "_y$", { desc = "Yank line without new line" })

keymap("n", "+", "<C-^>", { desc = "Go to Alternate file" })

keymap("n", "<Leader>d", '"_d', { desc = "Delete in normal mode without yanking" })
keymap("v", "<Leader>d", '"_d', { desc = "Delete in visual mode without yanking" })

keymap("n", "j", "gj", { desc = "Move down by visual line" })
keymap("n", "k", "gk", { desc = "Move up by visual line" })
keymap("v", "j", "gj", { desc = "Move down by visual line in visual mode" })
keymap("v", "k", "gk", { desc = "Move up by visual line in visual mode" })

-- Insert --
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap("i", "jj", "<ESC>", { desc = "Exit insert mode with jj" })
keymap("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

-- Visual --
keymap("v", "<", "<gv", { desc = "Indent left and maintain selection" })
keymap("v", ">", ">gv", { desc = "Indent right and maintain selection" })

-- Moves line shortcuts (∆ = alt+j, ˚ = alt+k)
keymap("n", "∆", ":m .+1<CR>==", { desc = "Move line down" })
keymap("n", "˚", ":m .-2<CR>==", { desc = "Move line up" })
keymap("i", "∆", "<ESC>:m .+1<CR>==gi", { desc = "Move line down in insert mode" })
keymap("i", "˚", "<ESC>:m .-2<CR>==gi", { desc = "Move line up in insert mode" })
keymap("v", "∆", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "˚", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

keymap("", "vv", "^vg_", { desc = "Select line content without indentation" })

-- Visual Block --
keymap("x", "J", ":move '>+1<CR>gv-gv", { desc = "Move block down" })
keymap("x", "K", ":move '<-2<CR>gv-gv", { desc = "Move block up" })
keymap("x", "∆", ":move '>+1<CR>gv-gv", { desc = "Move block down" })
keymap("x", "˚", ":move '<-2<CR>gv-gv", { desc = "Move block up" })

keymap("n", "<leader>q", ":bp|bd #<CR>", { desc = "Close buffer but keep window" })

-- Saving even when mistype
cmd("command! Wq wq") -- Allow WQ to work like wq
cmd("command! W w") -- Allow W to work like w
cmd("command! Q q") -- Allow Q to work like q
cmd("command! WQ wq") -- Allow WQ to work like wq

-- Remove trailing whitespace on save, but skip filetypes and paths where
-- trailing whitespace is meaningful (markdown hard breaks, diffs, patches,
-- vendored or generated files, etc.).
local skip_trim_filetypes = {
  ["markdown"] = true,
  ["diff"] = true,
  ["gitcommit"] = true,
  ["gitrebase"] = true,
  ["git"] = true,
  ["fugitive"] = true,
  ["fugitiveblame"] = true,
  [""] = true, -- unknown filetype
}

local skip_trim_path_patterns = {
  "/node_modules/",
  "/%.git/",
  "/dist/",
  "/build/",
  "/%.next/",
  "/vendor/",
  "/generated/",
  "/_generated/",
  "%.lock$",
  "%.min%.%w+$",
  "/lazy%-lock%.json$",
  "/package%-lock%.json$",
  "/yarn%.lock$",
  "/pnpm%-lock%.yaml$",
}

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("UserTrimTrailingWhitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local ft = vim.bo.filetype
    if skip_trim_filetypes[ft] then
      return
    end
    local path = vim.api.nvim_buf_get_name(0)
    if path ~= "" then
      for _, pat in ipairs(skip_trim_path_patterns) do
        if path:match(pat) then
          return
        end
      end
    end
    local save = vim.fn.winsaveview()
    pcall(vim.cmd, [[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

keymap(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Search And Replace The Word Under The Cursor" }
)
