require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local dap = require "dap"
local dapui = require "dapui"
-- local CopilotChat = require "CopilotChat"
local Copilot = require "copilot"
local agentic = require "agentic"

_G.copilot_inline_state = true

-- Existing mappings
map("v", "<Space>", "<Nop>", { silent = true })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")
map("n", "<leader>h", ":split<CR>", { desc = "Horizontal split" })
map("n", "<leader>v", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>q", ":close<CR>", { desc = "Close current split" })
map("n", "<leader>o", ":only<CR>", { desc = "Close all other splits" })
map("n", "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close all buffers" })

-- Debugging mappings
map("n", "<F5>", function()
  dap.continue()
end, { desc = "Start/Continue Debugging" })
map("n", "<F10>", function()
  dap.step_over()
end, { desc = "Step Over" })
map("n", "<F11>", function()
  dap.step_into()
end, { desc = "Step Into" })
map("n", "<F12>", function()
  dap.step_out()
end, { desc = "Step Out" })
map("n", "<Leader>db", function()
  dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })
map("n", "<Leader>dB", function()
  dap.set_breakpoint(vim.fn.input "Breakpoint Condition: ")
end, { desc = "Set Conditional Breakpoint" })
map("n", "<Leader>dl", function()
  dap.set_breakpoint(nil, nil, vim.fn.input "Log Message: ")
end, { desc = "Set Log Point" })
map("n", "<Leader>dr", function()
  dap.repl.open()
end, { desc = "Open REPL" })
map("n", "<Leader>du", function()
  dapui.toggle()
end, { desc = "Toggle Debug UI" })
map("n", "<Leader>dc", function()
  dap.terminate()
  dapui.close()
end, { desc = "Stop Debugging and Close UI" })
map("n", "<Leader>dl", function()
  dap.run_last()
end, { desc = "Run Last Debugging Session" })

-- Telescope DAP key mappings
map("n", "<Leader>df", ":Telescope dap frames<CR>", { desc = "DAP Frames" })
map("n", "<Leader>dbp", ":Telescope dap list_breakpoints<CR>", { desc = "List Breakpoints" })
map("n", "<Leader>dv", ":Telescope dap variables<CR>", { desc = "DAP Variables" })
map("n", "<Leader>dc", ":Telescope dap commands<CR>", { desc = "DAP Commands" })

-- Telescope
map("n", "<Leader>fd", ":Telescope lsp_definitions<CR>", { desc = "Go To Definition" })

-- LuaSnip Cancel
map("n", "<Leader>u", function()
  require("luasnip").unlink_current()
end, { desc = "LuaSnip Unlink Current" })

-- Lazygit
map("n", "<Leader>gg", ":LazyGit<CR>", { desc = "LazyGit" })

-- CMake for C/CPP
-- map("n", "<Leader>cm", function()
--   vim.fn.jobstart("bash " .. vim.fn.expand("~/Scripts/ccmake.sh"), {
--     cwd = vim.fn.getcwd(),
--     on_exit = function()
--       vim.schedule(function()
--         vim.cmd("LspRestart")
--       end)
--     end,
--   })
-- end, { desc = "Run C Make Script then Restart LSP" })
--
-- map("n", "<Leader>cp", function()
--   vim.fn.jobstart("bash " .. vim.fn.expand("~/Scripts/cppcmake.sh"), {
--     cwd = vim.fn.getcwd(),
--     on_exit = function()
--       vim.schedule(function()
--         vim.cmd("LspRestart")
--       end)
--     end,
--   })
-- end, { desc = "Run CPP Make Script then Restart LSP" })

-- Livegrep For CPP REF OFFLINE
map("n", "<leader>fc", function()
  require("telescope.builtin").live_grep {
    search_dirs = { "~/cppRef" },
    glob_pattern = "*.html",
  }
end, { desc = "Search cppreference (offline)" })

-- Copilot nvim all leader key mappings
-- map("n", "<Leader>cc", ":Copilot chat<CR>", { desc = "Copilot Chat" })
-- map("n", "<Leader>cp", ":Copilot panel<CR>", { desc = "Copilot Panel" })
-- map("n", "<Leader>cs", ":Copilot status<CR>", { desc = "Copilot Status" })
-- map("n", "<Leader>ct", ":Copilot toggle<CR>", { desc = "Toggle Copilot" })
-- map("n", "<Leader>cK", ":Copilot usage<CR>", { desc = "Copilot Usage" })
-- map("n", "<Leader>co", ":Copilot Suggestion<CR>", { desc = "Copilot Suggestion" })

-- Main CopilotChat Controls
-- map({ "n" }, "<leader>aca", function()
--   CopilotChat.toggle()
-- end, { desc = "Toggle Copilot Chat" })
-- map({ "n" }, "<leader>ax", function()
--   CopilotChat.reset()
-- end, { desc = "Clear Copilot Chat" })
-- map({ "n" }, "<leader>aq", function()
--   vim.ui.input({ prompt = "Quick Chat: " }, function(input)
--     if input and input ~= "" then
--       CopilotChat.ask(input)
--     end
--   end)
-- end, { desc = "Quick Ask Copilot" })
-- map("n", "<leader>acm", ":CopilotChatModels<cr>", { desc = "Copilot Chat Models" })

-- Code Intelligence (Visual Mode)
-- map("v", "<leader>ae", "<cmd>CopilotChatExplain<cr>", { desc = "Explain selected code" })
-- map("v", "<leader>ar", "<cmd>CopilotChatReview<cr>", { desc = "Review selected code" })
-- map("v", "<leader>af", "<cmd>CopilotChatRefactor<cr>", { desc = "Refactor selected code" })
-- map("v", "<leader>ao", "<cmd>CopilotChatOptimize<cr>", { desc = "Optimize selected code" })
-- map("v", "<leader>at", "<cmd>CopilotChatTests<cr>", { desc = "Generate tests for selected code" })

-- Prompt Templates
-- map({ "n", "v" }, "<leader>acp", function()
--   CopilotChat.select_prompt()
-- end, { desc = "Prompt Actions (CopilotChat)" })

-- AgenticInput Controls
map({ "n", "v" }, "<leader>aa", function()
  agentic.toggle()
end, { desc = "Toggle AgenticInput" })
map({ "n", "v" }, "<leader>ac", function()
  agentic.add_selection_or_file_to_context()
end, { desc = "Mentor: Add to Context" })
map("n", "<leader>ae", function()
  agentic.add_current_line_diagnostics()
end, { desc = "Mentor: Explain Error" })
map("n", "<leader>as", function()
  require("agentic").switch_provider()
end, { desc = "Select Agent" })

-- toggle inline suggestion on and off
map("n", "<leader>ci", function()
  local ok, suggestion = pcall(require, "copilot.suggestion")
  if ok then
    suggestion.toggle_auto_trigger()
    _G.copilot_inline_state = not _G.copilot_inline_state
    if _G.copilot_inline_state then
      print "Copilot Inline Suggestion: ON"
    else
      print "Copilot Inline Suggestion: OFF"
    end
  end
end, { desc = "Toggle Copilot Inline Suggestion" })

-- Markdown Keymaps
map("n", "<leader>mdt", ":Markview toggle<CR>", { desc = "Toggle Markview" })
map("n", "<leader>mds", ":Markview splitToggle<CR>", { desc = "Toggle Markview Split" })
map("n", "<leader>mda", ":Markview attach<CR>", { desc = "Attach Markview to current buffer" })
