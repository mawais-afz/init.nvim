return {
  {
    "stevearc/aerial.nvim",
    opts = function()
      -- Define icons for different symbol kinds
      local icons = {
        Array = "󰅪",
        Boolean = "󰔡",
        Class = "󰌗",
        Constant = "󰏿",
        Constructor = "󰌗",
        Enum = "󰒻",
        EnumMember = "󰒻",
        Event = "󰆔",
        Field = "󰇽",
        File = "󰈙",
        Function = "󰊕",
        Interface = "󰈝",
        Key = "󰌋",
        Method = "󰊕",
        Module = "󰆧",
        Namespace = "󰌗",
        Null = "󰟢",
        Number = "󰎠",
        Object = "󰅩",
        Operator = "󰆕",
        Package = "󰏗",
        Property = "󰜢",
        String = "󰀬",
        Struct = "󰌗",
        TypeParameter = "󰊄",
        Variable = "󰆦",
        Control = "󰅩", -- For Lua control structures
      }

      -- HACK: fix lua's weird choice for `Package` for control
      -- structures like if/else/for/etc.
      icons.lua = { Package = icons.Control }

      local opts = {
        attach_mode = "global",
        backends = { "lsp", "treesitter", "markdown", "man" },
        show_guides = true,
        layout = {
          resize_to_content = false,
          win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
        },
        icons = icons,
        -- stylua: ignore
        guides = {
          mid_item   = "├╴",
          last_item  = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
        -- Highlighting options
        highlight_mode = "split_width",
        highlight_closest = true,
        highlight_on_hover = true,
        highlight_on_jump = 300,
        close_behavior = "global",
        close_on_select = false,
        default_direction = "prefer_right",
        placement_editor_edge = false,
        lsp = {
          diagnostics_trigger_update = true,
          update_when_errors = true,
          update_delay = 300,
        },
        treesitter = {
          update_delay = 300,
        },
        markdown = {
          update_delay = 300,
        },
        man = {
          update_delay = 300,
        },
      }
      return opts
    end,
    keys = {
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
    },
  },

  {
    "folke/trouble.nvim",
    optional = true,
    keys = {
      { "<leader>cs", false },
    },
  },

  -- edgy integration
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      -- Ensure edgy.nvim is loaded before aerial.nvim
      local function check_plugin_order()
        local plugins = require("lazy").plugins()
        local edgy_idx = nil
        local aerial_idx = nil
        
        for i, plugin in ipairs(plugins) do
          if plugin.name == "folke/edgy.nvim" then
            edgy_idx = i
          elseif plugin.name == "stevearc/aerial.nvim" then
            aerial_idx = i
          end
        end
        
        if edgy_idx and aerial_idx and edgy_idx > aerial_idx then
          vim.notify(
            "The `edgy.nvim` plugin must be loaded before `aerial.nvim` for proper integration.",
            vim.log.levels.WARN,
            { title = "Plugin Order Warning" }
          )
        end
      end

      -- Run the check after all plugins are loaded
      vim.defer_fn(check_plugin_order, 0)

      -- Configure edgy.nvim integration
      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "Aerial",
        ft = "aerial",
        pinned = true,
        open = "AerialOpen",
        size = 40, -- Set a fixed width for the aerial window
        filter = function(win)
          -- Only show aerial window for supported filetypes
          local ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), "filetype")
          return vim.tbl_contains({ "lua", "python", "javascript", "typescript", "rust", "go" }, ft)
        end,
      })
    end,
  },
}
