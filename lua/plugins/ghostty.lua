if vim.fn.has("macunix") == 0 then
  return {}
end

local ghostty_vimfiles = "/Applications/Ghostty.app/Contents/Resources/vim/vimfiles/"

if vim.fn.isdirectory(ghostty_vimfiles) == 0 then
  return {}
end

return {
  "ghostty",
  dir = ghostty_vimfiles,
  lazy = false,
}
