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
    require("vim._core.ui2").enable {
      enable = true, -- Whether to enable or disable the UI.
      msg = { -- Options related to the message module.
        target = "msg", ---@type 'cmd'|'msg' Default message target if not present in targets.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        ---or table mapping |ui-messages| kinds and triggers to a target.
        -- targets = {}, ---@type table<string, 'cmd'|'msg'|'pager'> Kind specific message targets.
        -- targets - "cmd"
        -- targets = {
        -- 	[""] = "msg", -- Default/fallback for messages without a specific target
        -- 	empty = "cmd", -- Empty command-line state
        -- },
        -- targets = {
        -- [""] = "msg", -- Default/fallback for messages without a specific target
        -- bufwrite = "msg", -- Write/save messages
        -- confirm = "cmd", -- Yes/no style prompts
        -- emsg = "pager", -- Editor errors
        -- echo = "msg", -- :echo output
        -- echomsg = "msg", -- :echomsg output
        -- echoerr = "pager", -- :echoerr output
        -- 	completion = "cmd", -- Command-line completion UI
        -- 	list_cmd = "pager", -- Command listings (e.g. :autocmd)
        -- 	lua_error = "pager", -- Lua errors
        -- lua_print = "msg", -- Lua print() output
        -- 	progress = "pager", -- Progress output (e.g. LSP progress)
        -- 	rpc_error = "pager", -- RPC/plugin communication errors
        -- 	quickfix = "msg", -- Quickfix-type messages
        -- 	search_cmd = "cmd", -- / or ? style search cmdline
        -- 	search_count = "cmd", -- “match 3 of 10” style search count
        -- 	shell_err = "pager", -- Shell errors
        -- 	shell_out = "pager", -- Shell output
        -- 	undo = "msg", -- Undo feedback
        -- 	verbose = "pager", -- Verbose output (e.g. from :verbose)
        -- wmsg = "msg", -- Warning messages
        -- 	typed_cmd = "cmd", -- The typed command-line itself (e.g. :echo hi)
        -- },
        cmd = { -- Options related to messages in the cmdline window.
          height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
        },
        dialog = { -- Options related to dialog window.
          height = 0.5, -- Maximum height.
        },
        msg = { -- Options related to msg window.
          height = 0.5, -- Maximum height.
          timeout = 4000, -- Time a message is visible in the message window.
        },
        pager = { -- Options related to message window.
          height = 1, -- Maximum height.
        },
      },
    }
  end)
end

-- nvim builtin
vim.cmd.packadd "nvim.undotree"
vim.cmd.packadd "nvim.difftool"

vim.g.python3_host_prog = "/home/vee/.local/share/mise/installs/python/3.12/bin/python"
