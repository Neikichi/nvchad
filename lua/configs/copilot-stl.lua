return function()
  local ok, copilot_client = pcall(require, "copilot.client")
  if not ok or copilot_client.is_disabled() then
    -- If copilot.lua isn't installed or is toggled off, exit gracefully
    vim.api.nvim_set_hl(0, "StCopilotOff", { fg = "#6272A4", bg = "NONE" })
    return "%#StCopilotOff#  "
  end

  -- 2. LAZY CONFIG: Safely check if the active LSP instance exists
  local ok_lsp, client = pcall(function()
    return vim.lsp.get_clients({ name = "copilot" })[1]
  end)

  if not ok_lsp or not client then
    return "" -- Copilot is installed, but hasn't attached to this specific buffer yet
  end

  -- 3. ANIMATION SPINNER: Check if copilot has active requests traveling over the network
  -- if client.requests and not vim.tbl_isempty(client.requests) then
  --   -- Uses copilot-lualine's classic burst star spinner frames
  --   local spinners = { "✶", "✸", "✹", "✺", "✹", "✷" }
  --
  --   if _G.copilot_spin_idx == nil then
  --     _G.copilot_spin_idx = 1
  --   end
  --   local frame = spinners[_G.copilot_spin_idx]
  --   _G.copilot_spin_idx = (_G.copilot_spin_idx % #spinners) + 1
  --
  --   vim.api.nvim_set_hl(0, "StCopilotSpin", { fg = "#50FA7B", bg = "NONE" })
  --   return "%#StCopilotSpin# " .. frame .. " "
  -- end

  -- 4. IDLE / READY STATE: Copilot is active and listening
  vim.api.nvim_set_hl(0, "StCopilotReady", { fg = "#50FA7B", bg = "NONE" })
  return "%#StCopilotReady#  "
end
