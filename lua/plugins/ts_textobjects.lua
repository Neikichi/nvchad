return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  -- lazy = false,
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local select = require "nvim-treesitter-textobjects.select"
    local move = require "nvim-treesitter-textobjects.move"
    local swap = require "nvim-treesitter-textobjects.swap"
    local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
    local map = vim.keymap.set

    -- ==========================================
    -- 1. SELECT TEXTOBJECTS (af, if, via, cia, etc.)
    -- ==========================================
    local function map_select(keys, capture, desc)
      map({ "x", "o" }, keys, function()
        select.select_textobject(capture, "textobjects")
      end, { desc = desc })
    end

    map_select("af", "@function.outer", "Select around function")
    map_select("if", "@function.inner", "Select inside function")
    map_select("ac", "@class.outer", "Select around class")
    map_select("ic", "@class.inner", "Select inside class")
    map_select("as", "@local.scope", "Select scope")
    map_select("ia", "@parameter.inner", "Select inside argument")
    map_select("aa", "@parameter.outer", "Select around argument")

    -- ==========================================
    -- 2. MOVE MOTIONS (]f, [f, ]], [[, ]a, etc.)
    -- ==========================================
    local function map_move(keys, fn, capture, desc)
      map({ "n", "x", "o" }, keys, function()
        fn(capture, "textobjects")
      end, { desc = desc })
    end

    -- Next start / end
    map_move("]f", move.goto_next_start, "@function.outer", "Next function start")
    map_move("]]", move.goto_next_start, "@class.outer", "Next class start")
    map_move("]o", move.goto_next_start, "@loop.outer", "Next loop start")
    map_move("]a", move.goto_next_start, "@parameter.inner", "Next argument start")
    map_move("]s", move.goto_next_start, "@local.scope", "Next scope start")
    map_move("]c", move.goto_next, "@conditional.outer", "Next conditional block")

    map_move("]F", move.goto_next_end, "@function.outer", "Next function end")
    map_move("][", move.goto_next_end, "@class.outer", "Next class end")
    map_move("]O", move.goto_next_end, "@loop.outer", "Next loop end")
    map_move("]A", move.goto_next_end, "@parameter.outer", "Next argument end")

    -- Previous start / end
    map_move("[f", move.goto_previous_start, "@function.outer", "Prev function start")
    map_move("[[", move.goto_previous_start, "@class.outer", "Prev class start")
    map_move("[o", move.goto_previous_start, "@loop.outer", "Prev loop start")
    map_move("[a", move.goto_previous_start, "@parameter.inner", "Prev argument start")
    map_move("[s", move.goto_previous_start, "@local.scope", "Prev scope start")
    map_move("[c", move.goto_previous, "@conditional.outer", "Prev conditional block")

    map_move("[F", move.goto_previous_end, "@function.outer", "Prev function end")
    map_move("[]", move.goto_previous_end, "@class.outer", "Prev class end")
    map_move("[O", move.goto_previous_end, "@loop.outer", "Prev loop end")
    map_move("[A", move.goto_previous_end, "@parameter.outer", "Prev argument end")

    -- ==========================================
    -- 3. SWAP PARAMETERS (<leader>a, <leader>A)
    -- ==========================================
    map("n", "<leader>a", function()
      swap.swap_next "@parameter.inner"
    end, { desc = "Swap parameter next" })

    map("n", "<leader>A", function()
      swap.swap_previous "@parameter.inner"
    end, { desc = "Swap parameter previous" })

    -- ==========================================
    -- 4. REPEATABLE MOVES (;, ,)
    -- ==========================================
    map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "Repeat move forward" })
    map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous, { desc = "Repeat move backward" })
  end,
}
