return {
  {
    "stevearc/aerial.nvim",
    event = "LazyFile",
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
      local edgy_idx = LazyVim.plugin.extra_idx("ui.edgy")
      local aerial_idx = LazyVim.plugin.extra_idx("editor.aerial")

      if edgy_idx and edgy_idx > aerial_idx then
        LazyVim.warn("The `edgy.nvim` extra must be **imported** before the `aerial.nvim` extra to work properly.", {
          title = "LazyVim",
        })
      end

      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "Aerial",
        ft = "aerial",
        pinned = true,
        open = "AerialOpen",
      })
    end,
  },

  -- lualine integration
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.sections.lualine_c, {
        "aerial",
        sep = " ",     -- separator between symbols
        sep_icon = "", -- separator between icon and symbol
        depth = 5,     -- number of symbols to render top-down
        dense = false, -- dense mode
        dense_sep = ".", -- separator in dense mode
        colored = true, -- color the symbol icons
      })
    end,
  },
}
