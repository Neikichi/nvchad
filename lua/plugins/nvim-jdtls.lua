return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" }, -- Only load when opening a Java file
  config = function()
    require "ftplugin.java" -- Load the Java LSP configuration
  end,
}
