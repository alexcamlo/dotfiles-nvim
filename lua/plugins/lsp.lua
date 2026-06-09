return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "b0o/SchemaStore.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "artemave/workspace-diagnostics.nvim",
      { "j-hui/fidget.nvim", opts = {} },
      {
        "OlegGulevskyy/better-ts-errors.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = {
          keymaps = {
            toggle = "<leader>dd",
            go_to_definition = "<leader>dx",
          },
        },
      },
    },
    config = function()
      vim.lsp.document_color.enable(false)

      vim.diagnostic.config({
        virtual_text = false,
        float = {
          focusable = false,
          border = "rounded",
          source = "if_many",
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
        update_in_insert = false,
        severity_sort = true,
      })

      require("mason").setup()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "astro-language-server",
          "biome",
          "css-lsp",
          "css-variables-language-server",
          "html-lsp",
          "json-lsp",
          "lua-language-server",
          "taplo",
          "tailwindcss-language-server",
          "vtsls",
          "yaml-language-server",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

      local lsp_servers_path = vim.fn.stdpath("config") .. "/after/lsp"
      local servers = {}

      for file in vim.fs.dir(lsp_servers_path) do
        local server = file:match("(.+)%.lua$")
        if server then
          table.insert(servers, server)
        end
      end

      table.sort(servers)

      for _, server in ipairs(servers) do
        local ok, config = pcall(dofile, lsp_servers_path .. "/" .. server .. ".lua")
        if not ok then
          vim.notify(("Failed to load LSP config for %s: %s"):format(server, config), vim.log.levels.ERROR)
        else
          config = config or {}
          if config.default_config then
            config = config.default_config
          end

          config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
          vim.lsp.config(server, config)
          vim.lsp.enable(server)
        end
      end

      vim.api.nvim_create_user_command("LspInfo", function()
        vim.cmd("checkhealth vim.lsp")
      end, { desc = "Show built-in LSP health/info" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
          end

          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
          vim.keymap.set("n", "<leader>e", function()
            vim.diagnostic.open_float({ border = "rounded" })
          end, vim.tbl_extend("force", opts, { desc = "Diagnostic float (line)" }))
        end,
      })
    end,
  },
}
