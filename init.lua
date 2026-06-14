vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Force Neovim 0.12 to use the modern, non-blocking UI2 message and pager buffers
if vim.fn.has "nvim-0.12" == 1 then
  pcall(function()
    require("vim._core.ui2").enable()
  end)
end

-- nvim builtin
vim.cmd.packadd "nvim.undotree"
vim.cmd.packadd "nvim.difftool"

vim.g.python3_host_prog = "/home/vee/.local/share/mise/installs/python/3.12/bin/python"
