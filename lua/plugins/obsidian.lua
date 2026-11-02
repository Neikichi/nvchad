return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = {
    "Obsidian", -- Loads space-separated commands like :Obsidian backlinks, :Obsidian open, etc.
    "ObsidianOpen",
    "ObsidianNew",
    "ObsidianQuickSwitch",
    "ObsidianSearch",
    "ObsidianWorkspace",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    -- Disable legacy command warnings & enable new subcommand structure
    legacy_commands = false,

    workspaces = {
      {
        name = "vee",
        path = vim.fn.expand "~/.vaults/vee",
      },
      {
        name = "work",
        path = vim.fn.expand "~/.vaults/work",
      },
    },

    -- UI config for conceallevel/rendering
    ui = {
      enable = true,
    },

    -- Checkbox config (Updated for Obsidian.nvim 3.x+)
    checkbox = {
      -- Order of state cycles when toggling
      order = { " ", "x" },
      create_new = true,
    },

    -- Custom state styling (Icons & highlight groups)
    checkboxes = {
      [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      ["x"] = { char = "", hl_group = "ObsidianDone" },
    },
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Set conceallevel dynamically for markdown buffers only
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })
  end,
}
