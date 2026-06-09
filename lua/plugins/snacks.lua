return {
  "folke/snacks.nvim",
  opts = {
    lazygit = {},
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    terminal = {
      win = { style = "terminal" },
    },
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    picker = {
      -- In case you want to make sure that the score manipulation above works
      -- or if you want to check the score of each file
      transform = function(item)
        if not item.file then
          return item
        end
        -- Demote the "TS definition" files:
        if item.file:match("%.d%.ts$") then
          item.score_add = (item.score_add or 0) - 1000
        end
        -- Boost the "neobean" keymaps file:
        -- if item.file:match("neobean/lua/config/keymaps%.lua") then
        --   item.score_add = (item.score_add or 0) + 100
        -- end
        return item
      end,
      debug = {
        scores = false, -- set to true to inspect picker scoring while tuning
      },
      -- I like the "ivy" layout, so I set it as the default globaly, you can
      -- still override it in different keymaps
      layout = {
        preset = "ivy",
        -- When reaching the bottom of the results in the picker, I don't want
        -- it to cycle and go back to the top
        cycle = false,
      },
      layouts = {
        -- I wanted to modify the ivy layout height and preview pane width,
        -- this is the only way I was able to do it
        -- NOTE: I don't think this is the right way as I'm declaring all the
        -- other values below, if you know a better way, let me know
        --
        -- Then call this layout in the keymaps above
        -- got example from here
        -- https://github.com/folke/snacks.nvim/discussions/468
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.5,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.5, border = "left" },
            },
          },
        },
      },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
            -- I'm used to scrolling like this in LazyGit
            -- ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
            -- ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
            -- ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
            -- ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
            ["<c-x>"] = { "edit_split", mode = { "i", "n" } },
            ["<c-y>"] = { "edit_vsplit", mode = { "i", "n" } },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>ss",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>cs",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>km",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    {
      "<leader>-",
      function()
        Snacks.picker.resume({
          on_show = function()
            vim.cmd.stopinsert()
          end,
        })
      end,
      desc = "Resume",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "-",
      function()
        Snacks.picker.files()
      end,
      desc = "Find files",
    },
    {
      "<leader>pb",
      function()
        Snacks.picker.buffers({
          -- I always want my buffers picker to start in normal mod
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } },
          },
          -- In case you want to override the layout for this keymap
          -- layout = "ivy",
        })
      end,
      desc = "Snacks [P]picker [B]buffers",
    },
    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions({
          matcher = {
            frecency = true,
            history_bonus = true,
          },
          auto_confirm = true,
        })
      end,
      desc = "Go to Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>sls",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>slS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },

    {
      "<leader>tt",
      function()
        Snacks.terminal.toggle()
      end,
      desc = "LSP Workspace Symbols",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Marks",
    },
  },
}
