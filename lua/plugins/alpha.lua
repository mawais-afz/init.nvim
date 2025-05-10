return {
  {
    'folke/snacks.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      dashboard = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart Find Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,         desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,            desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n",       function() Snacks.picker.notifications() end,   desc = "Notification History" },
      { "<leader>e",       function() Snacks.explorer() end,               desc = "File Explorer" },
    },
  },
  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- Header
      local logo = [[
           ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
           ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
           ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
           ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
           ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
           ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
      ]]

      dashboard.section.header.val = vim.split(logo, "\n")

      -- Buttons
      dashboard.section.buttons.val = {
        dashboard.button("f", "🔍 " .. " Find file", "<cmd> Telescope find_files <cr>"),
        dashboard.button("n", "📄 " .. " New file", [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("r", "🕒 " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
        dashboard.button("g", "🔎 " .. " Find text", "<cmd> Telescope live_grep <cr>"),
        dashboard.button("c", "⚙️ " .. " Config", "<cmd> e $MYVIMRC <cr>"),
        dashboard.button("s", "💾 " .. " Sessions", "<cmd> Telescope session-lens search_session <cr>"),
        dashboard.button("p", "📦 " .. " Plugins", "<cmd> Telescope find_files cwd=~/.config/nvim/lua/plugins <cr>"),
        dashboard.button("t", "🎨 " .. " Theme", "<cmd> Telescope colorscheme <cr>"),
        dashboard.button("x", "  " .. " Lazy Extras", "<cmd> LazyExtras <cr>"),
        dashboard.button("l", "󰒲  " .. " Lazy", "<cmd> Lazy <cr>"),
        dashboard.button("q", "❌ " .. " Quit", "<cmd> qa <cr>"),
      }

      -- Footer
      dashboard.section.footer.val = {
        "Welcome to Neovim!",
        "Press <leader> to see available keymaps",
      }

      -- Layout
      dashboard.config.layout = {
        { type = "padding", val = 2 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 2 },
        dashboard.section.footer,
      }

      -- Setup
      alpha.setup(dashboard.config)
    end,
  },
}
