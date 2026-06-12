local ensure_installed = {
  "json",
  "toml",
  "javascript",
  "typescript",
  "tsx",
  "yaml",
  "html",
  "css",
  "graphql",
  "bash",
  "lua",
  "vim",
  "dockerfile",
  "gitignore",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup()
      treesitter.install(ensure_installed):wait(300000)
      vim.cmd.TSUpdate()
    end,
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("nvim-treesitter").setup()

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
        callback = function(args)
          local filetype = vim.bo[args.buf].filetype
          if filetype == "yaml" then
            pcall(vim.treesitter.start, args.buf)
            return
          end

          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      require("nvim-ts-autotag").setup()

      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },
}
