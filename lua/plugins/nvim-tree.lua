return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = {
    modified = {
      enable = true,
      -- show_on_dirs = true,
      -- show_on_open_dirs = true,
    },
    view = {
      width = 30,
      adaptive_size = true,
      preserve_window_proportions = true,
    },
    renderer = {
      group_empty = true,
    },
on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      -- 1. CRITICAL: Load nvim-tree's default mappings first!
      -- This fixes the Enter key going to a newline issue.
      api.config.mappings.default_on_attach(bufnr)

      -- 2. Helper to generate options for our custom keymaps
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- 3. Inject the easy-dotnet template creator onto Shift + A
      vim.keymap.set("n", "A", function()
        local node = api.tree.get_node_under_cursor()
        if not node then return end
        
        local path = node.type == "directory" and node.absolute_path or vim.fs.dirname(node.absolute_path)
        require("easy-dotnet").create_item(path)
      end, opts("Create item with .NET templates"))
    end,
  },
}
