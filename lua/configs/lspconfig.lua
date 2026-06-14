-- 1. Initialize NvChad's default diagnostic settings and global configurations
require("nvchad.configs.lspconfig").defaults()

vim.diagnostic.config { virtual_text = false }

-- 2. Configure specialized language servers with custom arguments/settings

-- Lua (lua_ls)
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
      hint = { enable = true },
    },
  },
})
vim.lsp.enable "lua_ls"

-- Clangd (C / C++)
vim.lsp.config("clangd", {
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
})
vim.lsp.enable "clangd"

-- TSGo (JavaScript / TypeScript custom runner)
vim.lsp.config("tsgo", {
  cmd = { "tsgo", "--lsp", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git", "tsconfig.base.json" },
})
vim.lsp.enable "tsgo"

-- Tailwind CSS
vim.lsp.config("tailwindcss", {
  filetypes = {
    "html",
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "php",
    "twig",
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "postcss.config.js",
    "postcss.config.cjs",
    ".git",
  },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        javascript = "html",
        javascriptreact = "html",
        typescript = "html",
        typescriptreact = "html",
      },
    },
  },
})
vim.lsp.enable "tailwindcss"

-- BasedPyright (Python)
vim.lsp.config("basedpyright", {
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
})
vim.lsp.enable "basedpyright"

-- Dockerfile & Docker Compose
vim.lsp.config("dockerls", {
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile", "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml", ".git" },
})
vim.lsp.enable "dockerls"

vim.lsp.config("docker_compose_language_service", {
  filetypes = { "yaml.docker-compose" },
  root_markers = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml", ".git" },
})
vim.lsp.enable "docker_compose_language_service"

-- Nginx
vim.lsp.config("nginx_language_server", {
  filetypes = { "nginx" },
  root_markers = { "nginx.conf", ".git" },
})
vim.lsp.enable "nginx_language_server"

-- Roslyn (C# / .NET)
vim.lsp.config("roslyn_ls", {
  filetypes = { "cs", "razor" },
  settings = {
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "openFiles",
      dotnet_compiler_diagnostics_scope = "openFiles",
    },
    ["csharp|completion"] = {
      dotnet_complete_function_arguments = true,
      dotnet_provide_regex_completions = true,
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_show_name_completion_suggestions = true,
    },
  },
})
vim.lsp.enable "roslyn_ls"

-- 3. Batch activate your vanilla baseline language servers
local standard_servers = { "html", "cssls" }
vim.lsp.enable(standard_servers)
