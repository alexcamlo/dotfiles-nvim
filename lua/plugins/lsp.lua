return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "b0o/SchemaStore.nvim",
      "artemave/workspace-diagnostics.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      {
        "OlegGulevskyy/better-ts-errors.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = {
          keymaps = {
            toggle = "<leader>dd", -- default '<leader>dd'
            go_to_definition = "<leader>dx", -- default '<leader>dx'
          },
        },
      },
    },
    config = function()
      vim.lsp.document_color.enable(false)

      vim.diagnostic.config({
        virtual_text = false,
        -- virtual_text = {
        --   only_current_line = true,
        --   source = true,
        -- },
        float = {
          focusable = false,
          -- style = "minimal",
          border = "rounded",
          source = "if_many",
          -- Show severity icons as prefixes.
          -- prefix = function(diag)
          --   local level = vim.diagnostic.severity[diag.severity]
          --   local prefix = string.format(" %s ", signs[text])
          --   return prefix, "Diagnostic" .. level:gsub("^%l", string.upper)
          -- end,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          numhl = {
            [vim.diagnostic.severity.WARN] = "WarningMsg",
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
          },
        },
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      })

      require("mason").setup()

      ----------------------------------
      -- Server configuration
      ----------------------------------
      -- Get server names from after/lsp
      local servers = {}
      local lsp_servers_path = vim.fn.stdpath("config") .. "/after/lsp"

      for file in vim.fs.dir(lsp_servers_path) do
        local name = file:match("(.+)%.lua$")
        if name then
          servers[name] = true
        end
      end
      ----------------------------------
      -- Add servers automaticlly
      ----------------------------------
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

      for server, opts in pairs(servers) do
        vim.lsp.enable(server)
        vim.lsp.config(server, capabilities)
      end

      vim.api.nvim_create_user_command("LspInfo", function()
        vim.cmd("checkhealth vim.lsp")
      end, { desc = "Show built-in LSP health/info" })
    end,
  },
}
