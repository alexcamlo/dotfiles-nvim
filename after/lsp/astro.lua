---@type vim.lsp.Config
return {
  cmd = { "astro-ls", "--stdio" },
  filetypes = { "astro" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  init_options = {
    typescript = {},
  },
  on_new_config = function(new_config, new_root_dir)
    if not vim.tbl_get(new_config.init_options, "typescript") or new_config.init_options.typescript.tsdk then
      return
    end

    local local_tsdk = vim.fs.joinpath(new_root_dir, "node_modules", "typescript", "lib")
    if vim.uv.fs_stat(local_tsdk) then
      new_config.init_options.typescript.tsdk = local_tsdk
    end
  end,
}
