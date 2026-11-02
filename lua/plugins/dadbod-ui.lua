return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1

    -- Define your multiple connections here seamlessly
    vim.g.dbs = {
      {
        name = "Main UAT",
        url = "sqlserver://sa:Z4Pjfy&IJFg)^MPT@18.140.94.166:1433?Encrypt=true&TrustServerCertificate=true",
        database = "master",
      },
      {
        name = "Main Prod",
        url = "sqlserver://mwdbuser:Mrmwdbuser!!@13.215.39.80:1433/master?Encrypt=true&TrustServerCertificate=true",
      },
    }
  end,
}
