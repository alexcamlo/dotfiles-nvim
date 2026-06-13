return {
  "xvzc/chezmoi.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
  cmd = { "ChezmoiEdit", "ChezmoiList" },
  keys = {
    {
      "<leader>cz",
      function()
        require("chezmoi.pick").snacks()
      end,
      desc = "Chezmoi files",
    },
    {
      "<leader>cZ",
      function()
        require("chezmoi.pick").snacks(vim.fn.stdpath("config"), {
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
