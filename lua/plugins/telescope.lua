return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    opts.defaults = opts.defaults or {}

    -- Option A: "smart" truncates the path but keeps the filename visible
    -- Option B: "tail" only shows the filename (super clean)
    -- Option C: {"filename_first"} shows filename, then the directory path
    opts.defaults.path_display = { "smart" }

    -- Keep your wrap configuration from earlier
    -- opts.defaults.buffer_previewer_maker = function(filepath, bufnr, maker_opts)
    --   maker_opts = maker_opts or {}
    --   vim.api.nvim_set_option_value("wrap", true, { buf = bufnr })
    --   require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, maker_opts)
    -- end

    return opts
  end,
}
