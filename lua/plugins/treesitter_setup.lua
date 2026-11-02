-- lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Your target languages list
      local my_languages = {
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
        "printf",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "razor",
        "c",
        "cpp",
        "java",
        "c_sharp",
        "bash",
        "dockerfile",
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
        "xml",
      }

      -- Initialize main branch parser directory
      require("nvim-treesitter").setup {
        install_dir = vim.fn.stdpath "data" .. "/site",
      }

      -- Asynchronously trigger parser installations in background (non-blocking)
      local ts = require "nvim-treesitter"
      for _, lang in ipairs(my_languages) do
        pcall(ts.install, lang)
      end
    end,
  },
}
