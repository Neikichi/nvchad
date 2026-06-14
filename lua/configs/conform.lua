local options = {
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
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    json = { "prettierd" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },
    xml = { "xmlformat" },
    sh = { "shfmt" },
    nginx = { "nginxfmt" },
    cpp = { "clang_format" },
    -- java = { "google_java_format" },
    -- c = { "clang_format" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
}

return options
