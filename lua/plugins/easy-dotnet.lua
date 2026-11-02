return {
  "GustavEikaas/easy-dotnet.nvim",
  ft = { "cs", "razor" },
  -- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
  -- are highly recommended for a better experience
  dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
  config = function()
    local dotnet = require "easy-dotnet"
    -- Options are not required
    dotnet.setup {
      managed_terminal = {
        auto_hide = true, -- auto hides terminal if exit code is 0
        auto_hide_delay = 1000, -- delay before auto hiding, 0 = instant
        mappings = {
          next_tab = { lhs = "<Tab>", desc = "Next terminal tab" },
          prev_tab = { lhs = "<S-Tab>", desc = "Previous terminal tab" },
          new_terminal = { lhs = "+", desc = "New user terminal" },
          close_terminal = { lhs = "X", desc = "Close current terminal tab" },
          hide_panel = { lhs = "q", desc = "Hide terminal panel" },
        },
      },
      -- Optional configuration for external terminals (matches nvim-dap structure)
      external_terminal = nil,
      projx_lsp = {
        enabled = true,
      },
      lsp = {
        enabled = true, -- Enable builtin roslyn lsp
        set_fold_expr = false,
        preload_roslyn = true, -- Start loading roslyn before any buffer is opened
        roslynator_enabled = true, -- Automatically enable roslynator analyzer
        easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
        easy_dotnet_extension_enabled = true, -- Needs to be true for enhanced_rename and create_type_from_usage
        enhanced_rename = true, -- auto rename file when renaming class
        create_type_from_usage = false, -- code action for creating class from unresolved symbol in a separate file
        restart_roslyn_on_branch_change = false, -- Restart Roslyn when Git HEAD changes
        auto_refresh_codelens = true,
        suggest_updates = true, -- Periodically suggest roslyn-language-server updates
        analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
        razor = {
          enabled = true,
          html = {
            enabled = true,
            cmd = nil, -- Auto-detect project node_modules/.bin/vscode-html-language-server, then PATH
            request_timeout = 5000,
          },
        },
        config = {
          -- -- 1. Attach NvChad capabilities (enables inlay hints capability, cmp completion, etc.)
          -- capabilities = require("nvchad.configs.lspconfig").capabilities,
          --
          -- -- 2. Attach NvChad keymaps (gd, K, gr, etc.) & auto-enable inlay hints when buffer opens
          -- on_attach = function(client, bufnr)
          --   require("nvchad.configs.lspconfig").on_attach(client, bufnr)
          --
          --   if client.supports_method "textDocument/inlayHint" then
          --     vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          --   end
          -- end,
          --
          -- -- 3. Attach NvChad on_init handler
          -- on_init = require("nvchad.configs.lspconfig").on_init,
          settings = {
            -- =================================================================
            -- 1. INLAY HINTS SETTINGS
            -- Controls inline virtual text inserted into your code views.
            -- Note: Keys MUST use snake_case for Roslyn to process them!
            -- =================================================================
            ["csharp|inlay_hints"] = {
              -- Shows parameter labels for raw literal inputs: Calculate(amount: 1000, isValid: true)
              csharp_enable_inlay_hints_for_literal_parameters = true,

              -- Shows target types for modern constructor shorthand: List<string> x = new List<string>()
              csharp_enable_inlay_hints_for_implicit_object_creation = true,

              -- Shows resolved concrete type next to 'var' declarations: var (User) user = GetUser()
              csharp_enable_inlay_hints_for_implicit_variable_types = true,

              -- Shows parameter names when indexing items: list[index: 0]
              -- csharp_enable_inlay_hints_for_indexer_parameters = false,

              -- Shows type signatures inside lambda expressions: (int x, string y) => ...
              -- csharp_enable_inlay_hints_for_lambda_parameter_types = false,

              -- Shows parameter labels for all object creation calls: new User(id: 10)
              -- csharp_enable_inlay_hints_for_object_creation_parameters = false,

              -- Shows parameter names for standard method calls (non-literals): Process(data: myData)
              -- csharp_enable_inlay_hints_for_other_parameters = false,

              -- Shows types for all parameter declarations in method definitions
              -- csharp_enable_inlay_hints_for_parameter_types = false,

              -- Aggressive mode: Forces type annotations across all expressions and variables
              -- csharp_enable_inlay_hints_for_types = false,
            },

            -- -- Duplicate block to support modern unified Roslyn LSP schema
            -- ["dotnet_inlay_hints"] = {
            --   dotnet_enable_inlay_hints_for_literal_parameters = true,
            --   dotnet_enable_inlay_hints_for_implicit_object_creation = true,
            --   dotnet_enable_inlay_hints_for_implicit_variable_types = true,
            -- },

            -- =================================================================
            -- 2. COMPLETION & AUTOCOMPLETE SETTINGS
            -- Controls nvim-cmp / blink.cmp behavior during code completion.
            -- =================================================================
            ["csharp|completion"] = {
              -- Auto-expands method signatures with parameter placeholders when accepting completion
              dotnet_complete_function_arguments = true,

              -- Shows completions from unimported libraries/namespaces and automatically adds 'using'
              dotnet_show_completion_items_from_unimported_namespaces = true,

              -- Suggests idiomatic variable names based on the type (e.g., UserSession -> userSession)
              dotnet_show_name_completion_suggestions = true,

              -- Highlights regex symbols and auto-fills regex patterns inside string literals
              dotnet_provide_regex_completions = true,

              -- Auto-imports extension methods in the completion menu from unimported namespaces
              dotnet_show_completion_items_from_unimported_extension_methods = true,

              -- Suppresses completion menu trigger when typing single-line comments or block docstrings
              -- dotnet_suppress_completion_item_from_unimported_namespaces = false,
            },

            -- =================================================================
            -- 3. BACKGROUND ANALYSIS & PERFORMANCE
            -- Controls CPU, RAM, and background diagnostic workload.
            -- =================================================================
            ["csharp|background_analysis"] = {
              -- Options: "openFiles" | "fullSolution" | "none"
              -- "openFiles": Low CPU/RAM. Analyzes strictly currently visible buffers.
              -- "fullSolution": High CPU/RAM. Runs background static analysis across all projects in .sln.
              dotnet_analyzer_diagnostics_scope = "openFiles",
              dotnet_compiler_diagnostics_scope = "openFiles",
            },

            -- =================================================================
            -- 4. CODE LENS SETTINGS
            -- Controls inline virtual metadata rendered directly above classes/methods.
            -- =================================================================
            ["csharp|code_lens"] = {
              -- Displays live reference counts above classes, methods, and properties ("4 references")
              dotnet_enable_references_code_lens = true,

              -- Displays 'Run Test' / 'Debug Test' virtual text links above unit test functions ([Fact], [TestMethod])
              -- dotnet_enable_tests_code_lens = false,
            },

            -- =================================================================
            -- 5. FORMATTING SETTINGS
            -- Applied when running document format via LSP or Conform.nvim.
            -- =================================================================
            ["csharp|formatting"] = {
              -- Automatically sorts and removes unused 'using' statements on format
              dotnet_organize_imports_on_format = true,
            },

            -- =================================================================
            -- 6. NAVIGATION & SYMBOL SEARCH
            -- Controls Go-To-Definition (gd) and assembly decompilation.
            -- =================================================================
            ["csharp|symbol_search"] = {
              -- Allows Go-To-Definition (gd) to search and navigate decompiled assembly code inside external NuGet packages
              dotnet_search_reference_assemblies = true,
            },

            -- =================================================================
            -- 7. HIGHLIGHTING & SEMANTIC TOKENS
            -- Controls LSP semantic token rendering.
            -- =================================================================
            ["csharp|highlighting"] = {
              -- Enables LSP semantic highlighting for C# tokens (types, parameters, fields, extension methods)
              dotnet_highlight_related_regex_components = true,
              dotnet_highlight_related_json_components = true,
            },
          },
        },
      },
      debugger = {
        -- Path to custom coreclr DAP adapter
        -- When set, this fully overrides `engine`; easy-dotnet-server uses this binary as-is.
        -- When nil, easy-dotnet-server falls back to its own bundled debugger selected by `engine`.
        bin_path = nil,
        -- Which bundled debugger to use when `bin_path` is nil.
        --   "netcoredbg" (default) — Samsung netcoredbg
        --   "dncdbg"               — viewizard/dncdbg (a fork of netcoredbg with a richer set of features)
        --   "sharpdbg"             — MattParkerDev/sharpdbg (a new debugger written in C#)
        engine = "netcoredbg",
        console = "integratedTerminal", -- Controls where the target app runs: "integratedTerminal" (Neovim buffer) or "externalTerminal" (OS window)
        apply_value_converters = true,
        auto_register_dap = true,
        mappings = {
          open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
        },
      },
      ---@type TestRunnerOptions
      test_runner = {
        auto_start_testrunner = true,
        hide_legend = false,
        -- Set to true when using neotest to avoid duplicate signs and conflicting buffer keymaps.
        neotest_integration = false,
        ---@type "split" | "vsplit" | "float" | "buf"
        viewmode = "float",
        ---@type number|nil
        vsplit_width = nil,
        ---@type string|nil "topleft" | "topright"
        vsplit_pos = nil,
        icons = {
          passed = "",
          skipped = "",
          failed = "",
          success = "",
          reload = "",
          test = "",
          sln = "󰘐",
          project = "󰘐",
          dir = "",
          package = "",
          class = "",
          build_failed = "󰒡",
        },
        mappings = {
          run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
          run_all_tests_from_buffer = { lhs = "<leader>t", desc = "Run all tests in file" },
          get_build_errors = { lhs = "<leader>e", desc = "get build errors" },
          peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
          debug_test_from_buffer = { lhs = "<leader>d", desc = "run test from buffer" },
          debug_test = { lhs = "<leader>d", desc = "debug test" },
          go_to_file = { lhs = "<leader>g", desc = "go to file" },
          run_all = { lhs = "<leader>R", desc = "run all tests" },
          run = { lhs = "<leader>r", desc = "run test" },
          peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
          expand = { lhs = "o", desc = "expand" },
          expand_node = { lhs = "E", desc = "expand node" },
          collapse_all = { lhs = "W", desc = "collapse all" },
          close = { lhs = "q", desc = "close testrunner" },
          refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
          cancel = { lhs = "<C-c>", desc = "cancel in-flight operation" },
          next_failure = { lhs = "]f", desc = "jump to next failing test" },
          prev_failure = { lhs = "[f", desc = "jump to previous failing test" },
        },
      },
      new = {
        project = {
          prefix = "sln", -- "sln" | "none"
        },
      },
      csproj_mappings = true,
      fsproj_mappings = true,
      auto_bootstrap_namespace = {
        --block_scoped, file_scoped
        type = "block_scoped",
        enabled = true,
        use_clipboard_json = {
          behavior = "prompt", --'auto' | 'prompt' | 'never',
          register = "+", -- which register to check
        },
      },
      server = {
        use_visual_studio = false, -- Set true for .NET Framework support on Windows
        ---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
        log_level = nil,
      },
      -- choose which picker to use with the plugin
      -- possible values are "telescope" | "fzf" | "snacks" | "basic"
      -- if no picker is specified, the plugin will determine
      -- the available one automatically with this priority:
      --  snacks -> fzf -> telescope ->  basic
      picker = "telescope",
      notifications = {
        --Set this to false if you have configured lualine to avoid double logging
        handler = function(start_event)
          local spinner = require("easy-dotnet.ui-modules.spinner").new()
          spinner:start_spinner(function()
            return start_event.job.name
          end)
          ---@param finished_event JobEvent
          return function(finished_event)
            spinner:stop_spinner(finished_event.result.msg, finished_event.result.level)
          end
        end,
      },
      diagnostics = {
        default_severity = "error",
        setqflist = true,
      },
      outdated = {
        mappings = {
          upgrade = { lhs = "<leader>pu", desc = "upgrade package under cursor" },
          upgrade_all = { lhs = "<leader>pa", desc = "upgrade all outdated packages" },
        },
      },
    }

    -- Example command
    vim.api.nvim_create_user_command("Secrets", function()
      dotnet.secrets()
    end, {})
    -- -- 🔧 FIX: Inject missing inlayHint capability into easy-dotnet's LSP config
    -- vim.api.nvim_create_autocmd("LspAttach", {
    --   callback = function(args)
    --     local client = vim.lsp.get_client_by_id(args.data.client_id)
    --     if client and client.name == "easy_dotnet" then
    --       client.server_capabilities.inlayHintProvider = true
    --       vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    --     end
    --   end,
    -- })
    -- Example keybinding
    vim.keymap.set("n", "<C-p>", function()
      vim.cmd "Dotnet run profile default"
    end)
  end,
}
