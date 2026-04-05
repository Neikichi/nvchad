-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "bearded-arc",
  transparency = true,

  -- hl_override = {
  --   -- === Types (blue, strong) ===
  --   ["@lsp.type.class"] = { fg = "#4e8fd8" }, -- IntelliJ class blue
  --   ["@lsp.type.interface"] = { fg = "#4e8fd8", italic = true },
  --   ["@lsp.type.enum"] = { fg = "#c77dbb" },
  --   ["@lsp.type.type"] = { fg = "#4e8fd8" },
  --
  --   -- === Methods (yellow-ish) ===
  --   ["@lsp.type.method"] = { fg = "#e2b86b" },
  --   ["@lsp.type.function"] = { fg = "#e2b86b" },
  --
  --   -- === Fields / properties (default text, subtle) ===
  --   ["@lsp.type.field"] = { fg = "#c0caf5" },
  --   ["@lsp.type.property"] = { fg = "#c0caf5" },
  --
  --   -- === Parameters (slightly dimmed) ===
  --   ["@lsp.type.parameter"] = { fg = "#9aa5ce" },
  --
  --   -- === Locals / variables ===
  --   ["@lsp.type.variable"] = { fg = "#c0caf5" },
  --
  --   -- === Constants (UPPER_CASE) ===
  --   ["@lsp.type.constant"] = { fg = "#ff9e64", bold = true },
  --
  --   -- === Static members (IntelliJ italics) ===
  --   ["@lsp.mod.static"] = { italic = true },
  --
  --   -- === Keywords (less loud, IntelliJ-like) ===
  --   ["@keyword"] = { fg = "#bb9af7", italic = true },
  --
  --   -- === Generics / brackets clarity ===
  --   ["@punctuation.bracket"] = { fg = "#7dcfff" },
  --   ["@punctuation.delimiter"] = { fg = "#89ddff" },
  -- },
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "default",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "lncol" },
    modules = {
      lncol = function()
        local ft = vim.bo.filetype

        local ingore_ft = {
          "AgenticChat",
          "AgenticInput",
          "AgenticCode",
          "AgenticFiles",
          "AgenticDiagnostics",
          "NvimTree",
          "lazy",
          "mason",
          -- "toggleterm",
        }

        if vim.tbl_contains(ingore_ft, ft) then
          return ""
        end

        -- return "%#StText# Ln %l, Col %c " -- Highlight group + line and column
        -- return " %l/%c %#St_Pos_sep# %#St_Pos_bg# %#St_Pos_txt#"
        return "%#St_pos_sep#%#St_pos_icon# %#St_Pos_text# %l/%c "
      end,

      -- f = "%F"
    },
  },
}

return M
