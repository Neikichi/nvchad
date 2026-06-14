return {
  {
    "echasnovski/mini.surround",
    keys = { "sa", "sd", "sr", "sf", "sF", "sh" },
    -- init = function()
    --   -- Register the descriptions with WhichKey cleanly
    --   local status_ok, which_key = pcall(require, "which-key")
    --   if status_ok then
    --     which_key.add {
    --       { "sa", desc = "Add Surrounding" },
    --       { "sd", desc = "Delete Surrounding" },
    --       { "sr", desc = "Replace Surrounding" },
    --       { "sf", desc = "Find Surrounding (Right)" },
    --       { "sF", desc = "Find Surrounding (Left)" },
    --       { "sh", desc = "Highlight Surrounding" },
    --     }
    --   end
    -- end,
    config = function()
      require("mini.surround").setup {
        mappings = {
          add = "sa", -- Add surrounding (Normal + Visual)
          delete = "sd", -- Delete surrounding
          find = "sf", -- Find surrounding to the right
          find_left = "sF", -- Find surrounding to the left
          highlight = "sh", -- Highlight surrounding
          replace = "sr", -- Replace surrounding
          update_n_lines = "sn", -- Update number of lines analyzed
        },
      }
    end,
  },
}
