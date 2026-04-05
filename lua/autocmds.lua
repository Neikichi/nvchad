require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.h",
  callback = function()
    vim.bo.filetype = "c"
  end,
})

vim.filetype.add {
  extension = {
    tpp = "cpp",
  },
}

autocmd("FileType", {
  pattern = "AgenticInput",
  callback = function()
    require("cmp").setup.buffer { enabled = false }
  end,
})

-- Load stdheader.vim if available
local stdheader_path = vim.fn.expand "~/.vim/plugin/stdheader.vim"
if vim.fn.filereadable(stdheader_path) == 1 then
  vim.cmd("source " .. stdheader_path)
end

-- Automatically insert 42header for new files
autocmd("BufNewFile", {
  pattern = { "*.c", "*.cpp", "*.h" },
  callback = function()
    vim.cmd "silent! 0r ~/.42header"
  end,
})

-- DAP UI management
local dap = require "dap"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath "data" .. "/mason/packages/codelldb/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = function()
      return vim.split(vim.fn.input "Enter arguments: ", " ")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp
