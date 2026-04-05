require "nvchad.options"

-- add yours here!
vim.opt.expandtab = false    -- Use tabs instead of spaces
vim.opt.shiftwidth = 4       -- Number of spaces used for each step of (auto)indent
vim.opt.tabstop = 4          -- Number of spaces that a <Tab> in the file counts for
vim.opt.softtabstop = 4      -- Number of spaces that a <Tab> counts for while editing
vim.opt.ruler = true
vim.opt.laststatus = 2

vim.opt.clipboard = 'unnamedplus'

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99      -- keep everything open by default
vim.opt.foldenable = true   -- enable folding

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
