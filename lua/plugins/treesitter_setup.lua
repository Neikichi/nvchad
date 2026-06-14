return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- Lock to the correct branch for 0.12
    lazy = false, -- As per documentation, treesitter cannot be lazy-loaded anymore
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "HiPhish/rainbow-delimiters.nvim",
    },
    config = function()
      -- 1. Define your personal target programming languages cleanly
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

      -- 2. Call the native main-branch setup function directly
      require("nvim-treesitter").setup {
        -- !!! FIX: Pass your table here so Treesitter registers them at runtime
        ensure_installed = my_languages,

        -- !!! FIX: Enable native syntax highlighting engine
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Explicitly direct the compiler output to your user data directory
        install_dir = vim.fn.stdpath "data" .. "/site",

        -- Your clean textobjects definitions
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "V",
            },
            keymaps = {
              ["af"] = { query = "@function.outer", desc = "Select around function" },
              ["if"] = { query = "@function.inner", desc = "Select inside function" },
              ["ac"] = { query = "@class.outer", desc = "Select around class" },
              ["ic"] = { query = "@class.inner", desc = "Select inside class" },
              ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select scope" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inside argument" },
              ["aa"] = { query = "@parameter.outer", desc = "Select around argument" },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function start" },
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              ["]o"] = { query = "@loop.outer", desc = "Next loop start" },
              ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
              ["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope start" },
            },
            goto_next_end = {
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
              ["]["] = { query = "@class.outer", desc = "Next class end" },
              ["]O"] = { query = "@loop.outer", desc = "Next loop end" },
              ["]A"] = { query = "@parameter.outer", desc = "Next argument end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Prev function start" },
              ["[["] = { query = "@class.outer", desc = "Prev class start" },
              ["[o"] = { query = "@loop.outer", desc = "Prev loop start" },
              ["[a"] = { query = "@parameter.inner", desc = "Prev argument start" },
              ["[s"] = { query = "@local.scope", query_group = "locals", desc = "Prev scope start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@function.outer", desc = "Prev function end" },
              ["[]"] = { query = "@class.outer", desc = "Prev class end" },
              ["[O"] = { query = "@loop.outer", desc = "Prev loop end" },
              ["[A"] = { query = "@parameter.outer", desc = "Prev argument end" },
            },
            goto_next = {
              ["]c"] = { query = "@conditional.outer", desc = "Next conditional block" },
            },
            goto_previous = {
              ["[c"] = { query = "@conditional.outer", desc = "Prev conditional block" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = { query = "@parameter.inner", desc = "Swap parameter next" },
            },
            swap_previous = {
              ["<leader>A"] = { query = "@parameter.inner", desc = "Swap parameter previous" },
            },
          },
        },
      }

      -- Set up rainbow delimiters strategy
      require("rainbow-delimiters.setup").setup {
        strategy = {
          [""] = "rainbow-delimiters.strategy.global",
          vim = "rainbow-delimiters.strategy.local",
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

      -- 3. Synchronously compile your entire language list on launch
      pcall(function()
        require("nvim-treesitter").install(my_languages):wait(60000)
      end)

      -- 4. Set up Repeatable Move Logic Mappings
      local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
      local map = vim.keymap.set
      map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "Repeat move forward" })
      map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "Repeat move backward" })
    end,
  },
}
