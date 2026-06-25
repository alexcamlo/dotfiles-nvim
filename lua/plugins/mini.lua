---@diagnostic disable: undefined-global
return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.ai").setup()
      require("mini.bracketed").setup()
      require("mini.diff").setup()
      require("mini.cursorword").setup()
      require("mini.icons").setup()
      require("mini.surround").setup()
      -- require('mini.statusline').setup()
      require("mini.colors").setup({
        mappings = {
          Apply = "<leader>mca",
          Write = "<leader>mcw",
        },
      })
      -- require("mini.pairs").setup()
      require("mini.indentscope").setup({
        draw = {
          delay = 1,
          animation = require("mini.indentscope").gen_animation.none(),
        },
        symbol = "│",
      })

      -- Mini.files clears netrw's FileExplorer augroup when it is used as the
      -- default explorer. Create it first so newer Neovim versions don't emit
      -- `E216: No such group or event: FileExplorer *` during startup.
      vim.api.nvim_create_augroup("FileExplorer", { clear = false })

      local mini_files = require("mini.files")
      mini_files.setup({
        mappings = {
          close = "",
          go_in = "L",
          go_in_plus = "l",
          go_out = "H",
          go_out_plus = "h",
        },
      })

      local minifiles_toggle = function(...)
        if not mini_files.close() then
          mini_files.open(vim.api.nvim_buf_get_name(0), false)
        end
      end

      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(MiniFiles.get_explorer_state().target_window, function()
            vim.cmd(direction .. " split")
            new_target_window = vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target_window)
          MiniFiles.go_in({ close_on_file = true })
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = "Split " .. direction
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          local map_buf = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { buffer = args.data.buf_id })
          end

          -- Tweak keys to your liking
          map_split(buf_id, "<C-x>", "belowright horizontal")
          map_split(buf_id, "<C-y>", "belowright vertical")

          map_buf("<Esc>", MiniFiles.close)
          map_buf("q", MiniFiles.close)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win_id = args.data.win_id

          -- Customize window-local settings
          local config = vim.api.nvim_win_get_config(win_id)
          config.border = "double"
          vim.api.nvim_win_set_config(win_id, config)
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          require("snacks").rename.on_rename_file(event.data.from, event.data.to)
        end,
      })

      vim.keymap.set("n", "<leader>e", minifiles_toggle, { desc = "Explorer", nowait = true })
      -- vim.keymap.set("n", "<leader>e", function()
      --   mini_files.open(vim.api.nvim_buf_get_name(0), false)
      -- end, { desc = "Explorer focused in current files folder", nowait = true })
    end,
  },
}
