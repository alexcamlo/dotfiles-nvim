return {
  {
    "mistweaverco/vhs-era-theme.nvim",
    config = function()
      -- vim.cmd("colorscheme vhs-era-theme")
      -- local palette_light = {
      --   -- #0f172a
      --   grey1 = "#f1f5f9",
      --   grey2 = "#e2e8f0",
      --   grey3 = "#cbd5e1",
      --   grey4 = "#94a3b8",
      --   blue = "#74d4ff",
      --   cyan = "#67e8f9",
      --   green = "#34d399",
      --   magenta = "#FB64B6",
      --   red = "#f87171",
      --   yellow = "#fcd34d",
      -- }
      -- local t = {
      --   bg = "#161616"),
      --   bgFloat = "#131313"),
      --   fg = "#f2f4f8"),
      --   cursor = "#ffffff"),
      --
      --   -- Syntax colors
      --   keyword = "#78a9ff"), -- base09
      --   comment = "#525252"), -- base03 (adjusted)
      --   punctuation = "#3ddbd9"), -- base08
      --   method = "#ff7eb6"), -- base12
      --   type = "#78a9ff"), -- base09
      --   string = "#be95ff"), -- base14
      --   number = "#82cfff"), -- base15
      --   constant = "#42be65"), -- base13
      --   tag = "#3ddbd9"), -- base08
      --   attribute = "#08bdba"), -- base07
      --   property = "#33b1ff"), -- base11
      --   parameter = "#ee5396"), -- base10
      --   label = "#08bdba"), -- base07
      --
      --   -- Workspace colors
      --   primary = "#78a9ff"), -- base09
      --   selection = "#353535"),
      --   search = "#484848"),
      --   diffAdd = "#42be65"), -- base13
      --   diffChange = "#ffcc66"), -- base09
      --   diffDelete = "#ee5396"), -- base10
      --   added = "#42be65"), -- base13
      --   changed = "#ffcc66"), -- base09
      --   deleted = "#ee5396"), -- base10
      --
      --   diffText = "#78a9ff").lighten(15),
      --   error = "#ff7eb6"), -- base12 (adjusted for error)
      --   errorBG = "#3d2932"),
      --   warning = "#be95ff"), -- base14
      --   warningBG = "#332e40"),
      --   info = "#78a9ff"), -- base09
      --   infoBG = "#1f2d3d"),
      --   hint = "#82cfff"), -- base15
      --   mergeCurrent = "#2d3139"),
      --   mergeCurrentLabel = "#3d414d"),
      --   mergeIncoming = "#1d2d3d"),
      --   mergeIncomingLabel = "#2d3d4d"),
      --   mergeParent = "#2d2539"),
      --   mergeParentLabel = "#3d354d"),
      --
      --   diffInline = "#42be65"),
      --   diffInlineAdd = "#42be65"),
      --   diffInlineDelete = "#ff6666"),
      -- }

      -- vim.api.nvim_set_hl(0, "@lsp.type.variable", { fg = "#be95ff" })
      -- vim.api.nvim_set_hl(0, "string", { fg = "#f2f4f8" })
      -- vim.api.nvim_set_hl(0, "Normal", { bg = "#0f172a" })
      -- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#0f172a" })
      -- vim.api.nvim_set_hl(0, "Comment", { fg = "#94a3b8" })
      -- vim.api.nvim_set_hl(0, "@constructor.lua", { fg = "#3ddbd9" })
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({
        -- ...
      })

      vim.cmd("colorscheme github_dark_default")
    end,
  },
}
