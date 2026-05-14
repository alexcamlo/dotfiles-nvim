local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.runtimepath:prepend({ lazypath })

local installed, lazy = pcall(require, "lazy")
if not installed then
  return
end

lazy.setup({
  -- importing directories
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "base2tone_tailwind_dark" } },
  -- ui config
  ui = {
    border = "double",
    size = {
      width = 0.8,
      height = 0.8,
    },
  },

  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
