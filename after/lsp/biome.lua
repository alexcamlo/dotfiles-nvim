---@type vim.lsp.Config
return {
  cmd = { "biome", "lsp-proxy" },
  filetypes = {
    "astro",
    "css",
    "graphql",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "svelte",
    "typescript",
    "typescriptreact",
    "vue",
  },
  single_file_support = false,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root_file = vim.fs.find({ "biome.json", "biome.jsonc" }, { path = fname, upward = true })[1]
    if root_file then
      on_dir(vim.fs.dirname(root_file))
    end
  end,
}
