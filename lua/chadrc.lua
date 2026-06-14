-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",
  transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

  hl_add = {
    St_Lsp_Sep = { fg = "nord_blue", bg = "statusline_bg" },

    -- 2. Icon: Dark icon text sitting on a solid Nord Blue accent block background
    St_Lsp_Icon = { fg = "statusline_bg", bg = "nord_blue", bold = true },

    -- 3. Text: Nord text color sitting on a distinct, muted dark contrast container background
    St_Lsp_Text = { fg = "nord_blue" },
  },
}

M.nvdash = { load_on_startup = true }

M.ui = {
  --  tabufline = {
  --     lazyload = false
  -- }
  statusline = {
    theme = "default",
    separator_style = "default",
    order = {
      "mode",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "copilot",
      "diagnostics",
      "lsp",
      "cwd",
      "cursor",
    },
    modules = {
      copilot = require "configs.copilot-stl",
      lsp = function()
        local sep_style = require("nvconfig").ui.statusline.separator_style
        local utils = require "nvchad.stl.utils"

        local sep_icons = utils.separators
        local separators = (type(sep_style) == "table" and sep_style) or sep_icons[sep_style]

        local sep_l = separators["left"]
        local sep_r = separators["right"]

        if rawget(vim, "lsp") then
          local names = {}

          -- 1. Loop through ALL clients and collect their names
          for _, client in ipairs(vim.lsp.get_clients()) do
            -- NvChad v3.0 syntax for current buffer index mapping
            local builtin_ui = utils
            local buf = builtin_ui and builtin_ui.stbufnr() or vim.api.nvim_get_current_buf()

            if client.attached_buffers[buf] and client.name ~= "copilot" then
              table.insert(names, client.name)
            end
          end

          -- 2. If we found any attached servers, join them together
          if #names > 0 then
            local lsp_names = table.concat(names, " ")

            -- Responsive truncation trick matching NvChad style
            if vim.o.columns > 100 then
              -- We alternate the highlight tags for each individual component:
              return "%#St_Lsp_Sep#" .. sep_l .. "%#St_Lsp_Icon# " .. "%#St_Lsp_Text# " .. lsp_names .. " "
            else
              return "%#St_Lsp_Sep#" .. sep_l .. "%#St_Lsp_Icon# " .. "%#St_Lsp_Text# "
            end
          end
        end

        return ""
      end,
      -- lncol = function()
      --   local ft = vim.bo.filetype
      --
      --   local ingore_ft = {
      --     "AgenticChat",
      --     "AgenticInput",
      --     "AgenticCode",
      --     "AgenticFiles",
      --     "AgenticDiagnostics",
      --     "NvimTree",
      --     "lazy",
      --     "mason",
      --     -- "toggleterm",
      --   }
      --
      --   if vim.tbl_contains(ingore_ft, ft) then
      --     return ""
      --   end
      --
      --   -- return "%#StText# Ln %l, Col %c " -- Highlight group + line and column
      --   -- return " %l/%c %#St_Pos_sep# %#St_Pos_bg# %#St_Pos_txt#"
      --   return "%#St_pos_sep#%#St_pos_icon# %#St_Pos_text# %l/%c "
      -- end,
    },
  },
}

return M
