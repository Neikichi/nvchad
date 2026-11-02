require "nvchad.autocmds"

-- Nvdash: Open Nvdash when the last buffer is closed
-- vim.api.nvim_create_autocmd("BufDelete", {
--   callback = function()
--     local bufs = vim.t.bufs
--     if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
--       vim.cmd "Nvdash"
--     end
--   end,
-- })

-- Dotnet watch interactive
vim.keymap.set("n", "<leader>dw", function()
  local environments = { "Development", "UAT", "Production" }
  vim.ui.select(environments, { prompt = "Select ASPNETCORE_ENVIRONMENT:" }, function(choice)
    if not choice then
      return
    end
    vim.env.DOTNET_ROLL_FORWARD = "Major"
    vim.env.ASPNETCORE_ENVIRONMENT = choice
    vim.cmd("Dotnet watch --launch-profile " .. choice)
  end)
end, { desc = "Dotnet Watch Interactive" })

vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Dotnet terminal toggle<cr>", { desc = "Dotnet Terminal Toggle" })
