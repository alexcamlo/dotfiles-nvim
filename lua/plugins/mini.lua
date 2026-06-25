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

      local pick = require("mini.pick")
      pick.setup({
        mappings = {
          choose_in_split = "<C-x>",
          choose_in_vsplit = "<C-y>",
        },
        options = {
          use_cache = true,
        },
        window = {
          config = function()
            local height = math.floor(0.5 * vim.o.lines)
            return {
              anchor = "SW",
              border = "single",
              col = 0,
              height = height,
              row = vim.o.lines,
              width = vim.o.columns,
            }
          end,
        },
      })
      require("mini.extra").setup()

      local extra = require("mini.extra")

      local get_visual_selection = function()
        local _, start_row, start_col = unpack(vim.fn.getpos("v"))
        local _, end_row, end_col = unpack(vim.fn.getpos("."))
        if start_row > end_row or (start_row == end_row and start_col > end_col) then
          start_row, end_row = end_row, start_row
          start_col, end_col = end_col, start_col
        end

        local lines = vim.fn.getline(start_row, end_row)
        if #lines == 0 then
          return ""
        end

        lines[#lines] = string.sub(lines[#lines], 1, end_col)
        lines[1] = string.sub(lines[1], start_col)
        return table.concat(lines, "\n")
      end

      local grep_word_or_selection = function()
        local pattern = vim.fn.expand("<cword>")
        if vim.fn.mode():match("[vV]") then
          pattern = get_visual_selection()
        end
        pick.builtin.grep({ pattern = pattern, method = "plain" })
      end

      vim.keymap.set("n", "<leader>ss", function()
        pick.builtin.files()
      end, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>/", function()
        pick.builtin.grep_live()
      end, { desc = "Grep" })
      vim.keymap.set("n", "<leader>cs", function()
        extra.pickers.colorschemes()
      end, { desc = "Colorschemes" })
      vim.keymap.set("n", "<leader>km", function()
        extra.pickers.keymaps()
      end, { desc = "Keymaps" })
      vim.keymap.set({ "n", "x" }, "<leader>sw", grep_word_or_selection, { desc = "Visual selection or word" })
      vim.keymap.set("n", "<leader>-", function()
        pick.builtin.resume()
      end, { desc = "Resume" })
      vim.keymap.set("n", "<leader>sj", function()
        extra.pickers.list({ scope = "jump" })
      end, { desc = "Jumps" })
      vim.keymap.set("n", "-", function()
        pick.builtin.files()
      end, { desc = "Find files" })
      vim.keymap.set("n", "<leader>pb", function()
        local wipeout_cur = function()
          local current = pick.get_picker_matches().current
          if current and current.bufnr then
            vim.api.nvim_buf_delete(current.bufnr, {})
          end
        end
        pick.builtin.buffers({ include_current = true }, {
          mappings = { wipeout = { char = "<C-d>", func = wipeout_cur } },
        })
      end, { desc = "Pick buffers" })
      vim.keymap.set("n", "gd", function()
        extra.pickers.lsp({ scope = "definition" })
      end, { desc = "Go to Definition" })
      vim.keymap.set("n", "gD", function()
        extra.pickers.lsp({ scope = "declaration" })
      end, { desc = "Goto Declaration" })
      vim.keymap.set("n", "gr", function()
        extra.pickers.lsp({ scope = "references" })
      end, { desc = "References", nowait = true })
      vim.keymap.set("n", "gI", function()
        extra.pickers.lsp({ scope = "implementation" })
      end, { desc = "Goto Implementation" })
      vim.keymap.set("n", "gy", function()
        extra.pickers.lsp({ scope = "type_definition" })
      end, { desc = "Goto T[y]pe Definition" })
      vim.keymap.set("n", "<leader>sls", function()
        extra.pickers.lsp({ scope = "document_symbol" })
      end, { desc = "LSP Symbols" })
      vim.keymap.set("n", "<leader>slS", function()
        extra.pickers.lsp({ scope = "workspace_symbol" })
      end, { desc = "LSP Workspace Symbols" })
      vim.keymap.set("n", "<leader>sm", function()
        extra.pickers.marks()
      end, { desc = "Marks" })

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
      vim.keymap.set("n", "<leader>e", minifiles_toggle, { desc = "Explorer", nowait = true })
      -- vim.keymap.set("n", "<leader>e", function()
      --   mini_files.open(vim.api.nvim_buf_get_name(0), false)
      -- end, { desc = "Explorer focused in current files folder", nowait = true })
    end,
  },
}
