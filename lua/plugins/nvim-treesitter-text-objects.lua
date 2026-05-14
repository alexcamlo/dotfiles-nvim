local function select_textobject(query, query_group)
  return function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, query_group or "textobjects")
  end
end

local function swap_next(query)
  return function()
    require("nvim-treesitter-textobjects.swap").swap_next(query)
  end
end

local function swap_previous(query)
  return function()
    require("nvim-treesitter-textobjects.swap").swap_previous(query)
  end
end

local function move(method, query, query_group)
  return function()
    require("nvim-treesitter-textobjects.move")[method](query, query_group or "textobjects")
  end
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  event = "VeryLazy",
  config = function()
    require("nvim-treesitter-textobjects").setup({
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    })

    local select_keymaps = {
      ["a="] = { "@assignment.outer", "Select outer part of an assignment" },
      ["i="] = { "@assignment.inner", "Select inner part of an assignment" },
      ["l="] = { "@assignment.lhs", "Select left hand side of an assignment" },
      ["r="] = { "@assignment.rhs", "Select right hand side of an assignment" },
      ["a:"] = { "@property.outer", "Select outer part of an object property" },
      ["i:"] = { "@property.inner", "Select inner part of an object property" },
      ["l:"] = { "@property.lhs", "Select left part of an object property" },
      ["r:"] = { "@property.rhs", "Select right part of an object property" },
      aa = { "@parameter.outer", "Select outer part of a parameter/argument" },
      ia = { "@parameter.inner", "Select inner part of a parameter/argument" },
      ai = { "@conditional.outer", "Select outer part of a conditional" },
      ii = { "@conditional.inner", "Select inner part of a conditional" },
      al = { "@loop.outer", "Select outer part of a loop" },
      il = { "@loop.inner", "Select inner part of a loop" },
      af = { "@call.outer", "Select outer part of a function call" },
      ["if"] = { "@call.inner", "Select inner part of a function call" },
      am = { "@function.outer", "Select outer part of a method/function definition" },
      im = { "@function.inner", "Select inner part of a method/function definition" },
      ac = { "@class.outer", "Select outer part of a class" },
      ic = { "@class.inner", "Select inner part of a class" },
    }

    for key, mapping in pairs(select_keymaps) do
      vim.keymap.set({ "x", "o" }, key, select_textobject(mapping[1]), { desc = mapping[2] })
    end

    vim.keymap.set("n", "<leader>na", swap_next("@parameter.inner"), { desc = "Swap parameter/argument with next" })
    vim.keymap.set("n", "<leader>n:", swap_next("@property.outer"), { desc = "Swap object property with next" })
    vim.keymap.set("n", "<leader>nm", swap_next("@function.outer"), { desc = "Swap function with next" })
    vim.keymap.set(
      "n",
      "<leader>pa",
      swap_previous("@parameter.inner"),
      { desc = "Swap parameter/argument with previous" }
    )
    vim.keymap.set("n", "<leader>p:", swap_previous("@property.outer"), { desc = "Swap object property with previous" })
    vim.keymap.set("n", "<leader>pm", swap_previous("@function.outer"), { desc = "Swap function with previous" })

    local move_keymaps = {
      ["]f"] = { "goto_next_start", "@call.outer", "textobjects", "Next function call start" },
      ["]m"] = { "goto_next_start", "@function.outer", "textobjects", "Next method/function def start" },
      ["]c"] = { "goto_next_start", "@class.outer", "textobjects", "Next class start" },
      ["]i"] = { "goto_next_start", "@conditional.outer", "textobjects", "Next conditional start" },
      ["]l"] = { "goto_next_start", "@loop.outer", "textobjects", "Next loop start" },
      ["]s"] = { "goto_next_start", "@local.scope", "locals", "Next scope" },
      ["]z"] = { "goto_next_start", "@fold", "folds", "Next fold" },
      ["]F"] = { "goto_next_end", "@call.outer", "textobjects", "Next function call end" },
      ["]M"] = { "goto_next_end", "@function.outer", "textobjects", "Next method/function def end" },
      ["]C"] = { "goto_next_end", "@class.outer", "textobjects", "Next class end" },
      ["]I"] = { "goto_next_end", "@conditional.outer", "textobjects", "Next conditional end" },
      ["]L"] = { "goto_next_end", "@loop.outer", "textobjects", "Next loop end" },
      ["[f"] = { "goto_previous_start", "@call.outer", "textobjects", "Prev function call start" },
      ["[m"] = { "goto_previous_start", "@function.outer", "textobjects", "Prev method/function def start" },
      ["[c"] = { "goto_previous_start", "@class.outer", "textobjects", "Prev class start" },
      ["[i"] = { "goto_previous_start", "@conditional.outer", "textobjects", "Prev conditional start" },
      ["[l"] = { "goto_previous_start", "@loop.outer", "textobjects", "Prev loop start" },
      ["[F"] = { "goto_previous_end", "@call.outer", "textobjects", "Prev function call end" },
      ["[M"] = { "goto_previous_end", "@function.outer", "textobjects", "Prev method/function def end" },
      ["[C"] = { "goto_previous_end", "@class.outer", "textobjects", "Prev class end" },
      ["[I"] = { "goto_previous_end", "@conditional.outer", "textobjects", "Prev conditional end" },
      ["[L"] = { "goto_previous_end", "@loop.outer", "textobjects", "Prev loop end" },
    }

    for key, mapping in pairs(move_keymaps) do
      vim.keymap.set({ "n", "x", "o" }, key, move(mapping[1], mapping[2], mapping[3]), { desc = mapping[4] })
    end

    local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
