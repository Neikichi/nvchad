return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      formatters = {
        google_java_format = {
          command = "google-java-format",
          args = { "-" },
          stdin = true,
        },
        xmlformat = {
          args = { "--indent", "4", "-" },
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        markdown = { "prettierd" },
        yaml = { "prettierd" },
        xml = { "xmlformat" },
        sh = { "shfmt" },
        nginx = { "nginxfmt" },
        cpp = { "clang_format" },
        -- java = { "google_java_format" },
        -- c = { "clang_format" },
      },
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Core / Neovim
        "vim",
        "vimdoc",
        "lua",

        -- Web
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx", -- React / JSX / TSX

        -- Systems
        "c",
        "cpp",
        "java",

        -- Shell / DevOps
        "bash",
        "dockerfile",

        -- Docs / config
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
      },

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup {
        git = {
          enable = true,
          timeout = 500, -- Set Git timeout to 2000 ms (2 seconds)
          ignore = false, -- Show ignored files
        },
      }
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Debugging Plugins
  -- Core DAP plugin
  {
    "mfussenegger/nvim-dap",
  },
  -- UI for nvim-dap
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- Add nvim-nio as a dependency for dap-ui
    },
    config = function()
      require("dapui").setup()
    end,
  },
  -- Inline virtual text for debugging
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  -- Mason integration for managing debug adapters
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup {
        ensure_installed = { "codelldb" },
        automatic_setup = true,
      }
    end,
  },
  -- Telescope core plugin
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Telescope integration for nvim-dap
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension "dap"
    end,
  },
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      -- Load all default snippets from friendly-snippets (C++, Python, Java, etc.)
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load your custom snippets
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = { "~/.config/nvim/lua/snips" },
      }
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
        surrounds = {
          ["("] = { add = { "(", ")" } }, -- No space inside ()
          ["{"] = { add = { "{", "}" } }, -- No space inside {}
          ["["] = { add = { "[", "]" } }, -- No space inside []
          ["<"] = { add = { "<", ">" } }, -- No space inside <>
        },
      }
    end,
  },

  {
    {
      "kdheepak/lazygit.nvim",
      cmd = "LazyGit",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot", -- load only when this command is called
    event = "InsertEnter", -- lazy-load when you enter insert mode
    config = function()
      require("copilot").setup {
        suggestion = { enabled = true, auto_trigger = true },
        panel = { enabled = true },
        should_attach = function(bufnr, bufname)
          local filetype = vim.bo[bufnr].filetype

          if filetype == "AgenticInput" then
            return true
          end

          local default_should_attach = require("copilot.config.should_attach").default
          return default_should_attach(bufnr, bufname)
        end,

        filetypes = {
          markdown = true,
          help = true,
          AgenticInput = true,
        },
      }
    end,
  },
  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   branch = "main",
  --   cmd = "CopilotChat",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "nvim-tree/nvim-web-devicons",
  --     "stevearc/conform.nvim", -- Optional: for formatting
  --   },
  --   opts = function()
  --     local user = vim.env.USER or "User"
  --     user = user:sub(1, 1):upper() .. user:sub(2)
  --     return {
  --       auto_insert_mode = true,
  --       question_header = "  " .. user .. " ",
  --       answer_header = "  Copilot ",
  --       -- model = "claude-3.5-sonnet",
  --       window = {
  --         width = 0.4,
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     local chat = require "CopilotChat"
  --
  --     vim.api.nvim_create_autocmd("BufEnter", {
  --       pattern = "copilot-chat",
  --       callback = function()
  --         vim.opt_local.relativenumber = false
  --         vim.opt_local.number = false
  --         vim.opt_local.modifiable = true
  --       end,
  --     })
  --
  --     chat.setup(opts)
  --   end,
  -- },

  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      -- One handed keymap recommended, you will be using the mouse
      {
        "<leader>tc",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Color pick under cursor",
      },
    },
    ---@type oklch.Opts
    opts = {
      -- platform = "linux",
      wsl_use_windows_app = false,
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rd = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rd.strategy["global"],
          vim = rd.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        priority = {
          [""] = 110,
          lua = 210,
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },
  {
    "OXY2DEV/markview.nvim",
    ft = {
      "markdown",
      "md",
      "AgenticChat",
      "copilot-chat",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- local presets = require "markview.presets"
      require("markview").setup {

        filetypes = {
          "markdown",
          "md",
          "AgenticChat",
          "copilot-chat",
        },

        preview = {
          icon_provider = "devicons",
          ignore_buftypes = {},
        },
        markdown = {
          enable = true,

          -- headings = presets.headings.glow,
          -- code_blocks = presets.code_blocks.rounded,
          -- tables = presets.tables.rounded,
          -- horizontal_rules = presets.horizontal_rules.thick,
          -- list_items = presets.list_items.simple,
        },
      }
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup()
      vim.diagnostic.config { virtual_text = false } -- Disable Neovim's default virtual text diagnostics
    end,
  },
  {
    "carlos-algms/agentic.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      { "hakonharnes/img-clip.nvim", opts = {} },
    },
    opts = {
      provider = "gemini-acp",
      acp_providers = {
        -- ["gemini-acp"] = { name = "Gemini Mentor", command = "gemini", args = { "--acp" } },
        ["claude-acp"] = { name = "Claude Specialist (copilot)", command = "copilot", args = { "--acp" } },
        -- ["codex-acp"] = { name = "Codex Worker", command = "codex-acp", args = {} },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
}
