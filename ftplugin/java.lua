-- =========================================================
-- Java LSP (jdtls)
-- =========================================================

local jdtls = require "jdtls"
local nvlsp = require "nvchad.configs.lspconfig"

-- ---------------------------------------------------------
-- Project root
-- ---------------------------------------------------------
local bufname = vim.api.nvim_buf_get_name(0)

local root_marker =
  vim.fs.find({ ".git", "pom.xml", "build.gradle", "mvnw", "gradlew" }, { upward = true, path = bufname })[1]

local root_dir = root_marker and vim.fs.dirname(root_marker) or vim.fn.getcwd()

-- ---------------------------------------------------------
-- Workspace (required by jdtls)
-- ---------------------------------------------------------
local workspace_dir = vim.fn.stdpath "data" .. "/jdtls-workspaces/" .. vim.fn.fnamemodify(root_dir, ":t")

-- ---------------------------------------------------------
-- Mason paths
-- ---------------------------------------------------------
local mason_path = vim.fn.stdpath "data" .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"

local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- ---------------------------------------------------------
-- Java command
-- ---------------------------------------------------------
local java_cmd = vim.env.JAVA_HOME .. "/bin/java"

-- ---------------------------------------------------------
-- Start jdtls
-- ---------------------------------------------------------
jdtls.start_or_attach {
  cmd = {
    java_cmd,

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",

    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    launcher_jar,
    "-configuration",
    jdtls_path .. "/config_linux",
    "-data",
    workspace_dir,
  },

  root_dir = root_dir,

  on_attach = nvlsp.on_attach,
  -- on_attach = function(client, bufnr)
  --   -- NvChad defaults
  --   nvlsp.on_attach(client, bufnr)
  --
  --   -- Enable semantic tokens (CRITICAL for Java)
  --   if client.server_capabilities.semanticTokensProvider then
  --     vim.lsp.semantic_tokens.enable(bufnr, client.id)
  --     vim.notify("Enabled semantic tokens for Java", vim.log.levels.INFO)
  --   end
  -- end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  settings = {
    java = {
      eclipse = { downloadSources = true },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-21",
            path = vim.env.JAVA_HOME,
          },
        },
      },
    },
  },
}
