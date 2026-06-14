return {
  "khoido2003/roslyn-filewatch.nvim",
  ft = "cs",
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("roslyn-filewatch").setup {
      -- THIS is what actually stops the bloat. It explicitly prevents
      -- the plugin from scanning heavy, generated cache folders.
      ignore_dirs = { "bin", "obj", ".git", "node_modules" },
      debounce_ms = 200,
    }
  end,
}
