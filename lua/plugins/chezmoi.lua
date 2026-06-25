return {
  "xvzc/chezmoi.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.nvim" },
  cmd = { "ChezmoiEdit", "ChezmoiList" },
  keys = {
    {
      "<leader>cz",
      function()
        require("chezmoi.pick").mini()
      end,
      desc = "Chezmoi files",
    },
    {
      "<leader>cZ",
      function()
        require("chezmoi.pick").mini(vim.fn.stdpath("config"), {
          "--path-style",
          "absolute",
          "--include",
          "files",
          "--exclude",
          "externals",
        })
      end,
      desc = "Chezmoi Neovim files",
    },
  },
  opts = {
    edit = {
      watch = true,
    },
  },
}
