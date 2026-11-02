return {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },

  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },

  -- concurrency = 4,
  -- git = {
  --   timeout = 15,
  -- },
}

-- {
--   change_detection = {
--     enabled = true,
--     notify = true
--   },
--   checker = {
--     check_pinned = false,
--     enabled = false,
--     frequency = 3600,
--     notify = true
--   },
--   debug = false,
--   defaults = {
--     lazy = true
--   },
--   dev = {
--     fallback = false,
--     path = "/home/vlow/projects",
--     patterns = {}
--   },
--   diff = {
--     cmd = "git"
--   },
--   git = {
--     cooldown = 0,
--     filter = true,
--     log = { "-8" },
--     throttle = {
--       duration = 5000,
--       enabled = false,
--       rate = 2
--     },
--     timeout = 120,
--     url_format = "https://github.com/%s.git"
--   },
--   headless = {
--     colors = true,
--     log = true,
--     process = true,
--     task = true
--   },
--   install = {
--     colorscheme = { "nvchad", "habamax" },
--     missing = true
--   },
--   local_spec = true,
--   lockfile = "/home/vlow/.config/nvchad/lazy-lock.json",
--   performance = {
--     cache = {
--       enabled = true
--     },
--     reset_packpath = true,
--     rtp = {
--       disabled_plugins = { "2html_plugin", "tohtml", "getscript", "getscriptPlugin", "gzip", "logipat", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "syntax", "synmenu", "optwin", "compiler", "bugreport", "ftplugin" },
--       paths = {},
--       reset = true
--     }
--   },
--   pkg = {
--     cache = "/home/vlow/.local/state/nvchad/lazy/pkg-cache.lua",
--     enabled = true,
--     sources = { "lazy", "rockspec", "packspec" }
--   },
--   profiling = {
--     loader = false,
--     require = false
--   },
--   readme = {
--     enabled = true,
--     files = { "README.md", "lua/**/README.md" },
--     root = "/home/vlow/.local/state/nvchad/lazy/readme",
--     skip_if_doc_exists = true
--   },
--   rocks = {
--     enabled = true,
--     root = "/home/vlow/.local/share/nvchad/lazy-rocks",
--     server = "https://lumen-oss.github.io/rocks-binaries/"
--   },
--   root = "/home/vlow/.local/share/nvchad/lazy",
--   spec = { { "NvChad/NvChad",
--       branch = "v2.5",
--       import = "nvchad.plugins",
--       lazy = false
--     }, {
--       import = "plugins"
--     } },
--   state = "/home/vlow/.local/state/nvchad/lazy/state.json",
--   ui = {
--     backdrop = 60,
--     border = "none",
--     custom_keys = {
--       ["<localleader>i"] = { <function 1>,
--         desc = "Inspect Plugin"
--       },
--       ["<localleader>l"] = { <function 2>,
--         desc = "Open lazygit log"
--       },
--       ["<localleader>t"] = { <function 3>,
--         desc = "Open terminal in plugin dir"
--       }
--     },
--     icons = {
--       cmd = " ",
--       config = "",
--       debug = "● ",
--       event = " ",
--       favorite = " ",
--       ft = "",
--       import = " ",
--       init = " ",
--       keys = " ",
--       lazy = "󰂠 ",
--       list = { "●", "➜", "★", "‒" },
--       loaded = "",
--       not_loaded = "",
--       plugin = " ",
--       require = "󰢱 ",
--       runtime = " ",
--       source = " ",
--       start = " ",
--       task = "✔ "
--     },
--     pills = true,
--     size = {
--       height = 0.8,
--       width = 0.8
--     },
--     throttle = 33.333333333333,
--     title_pos = "center",
--     wrap = true
--   }
-- }
--
