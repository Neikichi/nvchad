local options = {
  formatters_by_ft = {
    -- Lua (Config)
    lua = { "stylua" },

    -- Web (Prettierd)
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    json = { "prettierd" },
    json5 = { "prettierd" },
    jsonc = { "prettierd" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },

    -- Systems & DevOps
    xml = { "xmlformat" },
    sh = { "shfmt" },
    nginx = { "nginxfmt" },
    cpp = { "clang_format" },
    c = { "clang_format" },
    -- java = { "google_java_format" },
    python = { "ruff_format" },
    cs = { "csharpier" },
    razor = { "csharpier" },
  },

  -- Customizing your specific formatters
  formatters = {
    google_java_format = {
      command = "google-java-format",
      args = { "-" },
      stdin = true,
    },
    xmlformat = {
      args = { "--indent", "4", "-" },
    },
  },
  format_on_save = {
    -- lsp_fallback = true,
    lsp_format = "fallback",
    timeout_ms = 2000,
  },
}

return options
