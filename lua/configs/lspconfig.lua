require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local servers = { "html", "cssls", "lua_ls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
vim.lsp.config.clangd = {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = { "compile_commands.json", "compile_flags.txt", ".git" },
  -- flags = { debounce_text_changes = 150 },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
vim.lsp.enable "clangd"

-- Configure tsserver before enabling
vim.lsp.config.tsserver = {
  cmd = { vim.fn.expand "~/.local/share/nvim/mason/bin/typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  -- 👇 new-style root_dir handler
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- print("[DEBUG] tsserver root_dir called with " .. fname)

    local markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" }
    local found = vim.fs.find(markers, { upward = true, path = fname })[1]
    local root = found and vim.fs.dirname(found) or vim.fn.getcwd()

    -- print("[DEBUG] tsserver activating at root: " .. root)
    on_dir(root) -- ✅ activates the LSP only for that directory
  end,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

vim.lsp.enable "tsserver"

vim.lsp.config.tailwindcss = {
  cmd = {
    "node",
    "/home/vee/qtest/tailwindcss-intellisense/packages/tailwindcss-language-server/bin/tailwindcss-language-server",
    "--stdio",
    "--oxide=/home/vee/qtest/tailwindcss-intellisense/packages/tailwindcss-language-server/bin/oxide-helper.js",
  },
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
    "plaintext",
  },
  root_markers = { "tailwind.config.js", "tailwind.config.cjs", "postcss.config.js", "postcss.config.cjs", ".git" },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        javascript = "html",
        javascriptreact = "html",
        typescript = "html",
        typescriptreact = "html",
      },
      experimental = {
        -- configFile = "./tailwind.config.js",  -- use project config if available
        configFile = vim.fn.expand "~/qtest/js/tailtest.css", -- ⬅️ explicitly tell LSP where your config is
        -- classRegex = {
        -- 	"tw`([^`]*)`",                     -- tw`text-red-500`
        -- 	"tw\\(([^)]*)\\)",                 -- tw("text-red-500")
        -- 	"tw\\.[a-zA-Z]+`([^`]*)`",         -- tw.something`text-red-500`
        -- 	"clsx\\(([^)]*)\\)",               -- clsx("text-red-500")
        -- },
      },
    },
  },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
vim.lsp.enable "tailwindcss"

vim.lsp.config.pyright = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  -- root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- print("[DEBUG] pyright root_dir called with " .. fname)

    local markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }
    local found = vim.fs.find(markers, { upward = true, path = fname })[1]
    local root = found and vim.fs.dirname(found) or vim.fn.getcwd()

    -- print("[DEBUG] pyright activating at root: " .. root)
    on_dir(root) -- ✅ activates the LSP only for that directory
  end,
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
vim.lsp.enable "pyright"
