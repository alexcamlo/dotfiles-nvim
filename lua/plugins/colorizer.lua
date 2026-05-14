return {
  "brenoprata10/nvim-highlight-colors",
  url = "https://github.com/pnx/nvim-highlight-colors.git",
  branch = "oklch-support",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    render = "background", -- 'background' or 'foreground' or 'virtual'
    enable_named_colors = true,
    enable_tailwind = true,
    enable_oklch = true,
    enable_var_usage = true,
    enable_hsl_without_function = true,
    custom_colors = {
      { label = "blueTW", color = "#3b82f6" },
      { label = "cyanTW", color = "#22d3ee" },
      { label = "tealTW", color = "#99f6e4" },
      { label = "greenTW", color = "#34d399" },
      { label = "pinkTW", color = "#f472b6" },
      { label = "purpleTW", color = "#c084fc" },
      { label = "lightredTW", color = "#fda4af" },
      { label = "redTW", color = "#fb7185" },
      { label = "orangeTW", color = "#fbbf24" },
      { label = "yellowTW", color = "#fde68a" },
    },
  },
  config = function(_, opts)
    local utils = require("nvim-highlight-colors.utils")

    local function escape_lua_pattern(value)
      return (value:gsub("([^%w])", "%%%1"))
    end

    local function find_project_css_files(root)
      local css_files = {}
      local targets = vim.fs.find(function(name, path)
        if not name:match("%.css$") then
          return false
        end
        return not path:match("/node_modules/") and not path:match("/%.git/") and not path:match("/dist/")
      end, { path = root, type = "file", limit = 20 })

      for _, file in ipairs(targets) do
        css_files[#css_files + 1] = file
      end
      return css_files
    end

    local function collect_tailwind_theme_colors()
      local root = vim.fs.root(
        0,
        { "tailwind.config.ts", "tailwind.config.js", "vite.config.ts", "package.json", ".git" }
      ) or vim.uv.cwd()
      local css_variables = {}

      for _, file in ipairs(find_project_css_files(root)) do
        local ok, lines = pcall(vim.fn.readfile, file)
        if ok then
          for _, line in ipairs(lines) do
            local name, value = line:match("%s*%-%-([%w%-]+):%s*([^;]+);")
            if name and value and value:match("^oklch%(") then
              css_variables[name] = value
            end
          end
        end
      end

      local custom_colors = {}
      local prefixes = {
        "accent",
        "bg",
        "border",
        "caret",
        "decoration",
        "divide",
        "fill",
        "from",
        "outline",
        "placeholder",
        "ring",
        "stroke",
        "text",
        "to",
        "via",
      }

      for name, value in pairs(css_variables) do
        for _, prefix in ipairs(prefixes) do
          custom_colors[#custom_colors + 1] = {
            label = escape_lua_pattern(prefix .. "-" .. name),
            color = value,
          }
        end
      end

      return custom_colors
    end

    opts.custom_colors = vim.list_extend(opts.custom_colors or {}, collect_tailwind_theme_colors())

    -- PR #173 relies on LSP documentColor for Tailwind when tailwindcss-language-server is attached.
    -- Its LSP renderer currently shifts ranges one line up and can pass non-#RRGGBB values through.
    -- Keep the patch local until the fork/upstream fixes it.
    utils.highlight_lsp_document_color = function(response, active_buffer_id, ns_id, positions, options)
      if response == nil then
        return
      end

      local function clamp01(value)
        value = tonumber(value) or 0
        return math.max(0, math.min(1, value))
      end

      local function byte(value, alpha)
        return math.floor((clamp01(value) * alpha * 255) + 0.5)
      end

      local results = {}
      for _, match in pairs(response) do
        local color = match.color or {}
        local alpha = clamp01(color.alpha == nil and 1 or color.alpha)
        local range = match.range

        if range and range.start and range["end"] then
          local result = {
            row = range.start.line,
            start_column = range.start.character,
            end_column = range["end"].character,
            value = string.format(
              "#%02x%02x%02x",
              byte(color.red, alpha),
              byte(color.green, alpha),
              byte(color.blue, alpha)
            ),
          }

          local is_already_highlighted = false
          for _, position in pairs(positions) do
            if
              position.row == result.row
              and position.start_column == result.start_column
              and position.end_column == result.end_column
            then
              is_already_highlighted = true
              break
            end
          end

          if not is_already_highlighted then
            utils.create_highlight(active_buffer_id, ns_id, result, options)
          end
          table.insert(results, result)
        end
      end

      return results
    end

    require("nvim-highlight-colors").setup(opts)
  end,
}
