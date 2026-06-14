return {
  {
    "hrsh7th/nvim-cmp",
    event = { "User FilePost", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })

      local cmp = require "cmp"

      cmp.setup(opts)

      -- 2. Configure cmp-cmdline for search ('/')
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- 3. Configure cmp-cmdline for command line (':')
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline {
          -- 1. FIXED ENTER KEY MAPPING
          ["<CR>"] = cmp.mapping {
            c = function(fallback)
              if cmp.visible() then
                -- If an item is highlighted, confirm it and close the menu
                if cmp.get_selected_entry() then
                  cmp.confirm { select = false }
                else
                  -- If the menu is open but nothing is highlighted, select the top match
                  cmp.confirm { select = true }
                end
              else
                -- If the menu is completely closed, execute whatever is typed safely
                fallback()
              end
            end,
          },

          -- 2. TAB MOVEMENTS WITH SELECTION CORRECTION
          ["<Tab>"] = cmp.mapping {
            c = function(_)
              if cmp.visible() then
                -- Highlight the next item and actively replace the command line string
                cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
              else
                cmp.complete()
              end
            end,
          },

          -- 3. SHIFT-TAB REVERSE CYCLE
          ["<S-Tab>"] = cmp.mapping {
            c = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
              else
                fallback()
              end
            end,
          },
        },

        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
