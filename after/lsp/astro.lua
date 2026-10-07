---@type vim.lsp.Config
return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  init_options = {
    typescript = {},
  },
  before_init = function(_, config)
    if config.init_options.typescript.tsdk then
      return
    end

    local ts_file = vim.fs.find("node_modules/typescript/lib/typescript.js", {
      path = config.root_dir,
      upward = true,
      type = "file",
    })[1]
    config.init_options.typescript.tsdk = ts_file and vim.fs.dirname(ts_file)
      or vim.fs.joinpath(
        vim.fn.stdpath("data"),
        "mason",
        "packages",
        "vtsls",
        "node_modules",
        "@vtsls",
        "language-server",
        "node_modules",
        "typescript",
        "lib"
      )
  end,
}
