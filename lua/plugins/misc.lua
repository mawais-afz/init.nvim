-- Standalone plugins with less than 10 lines of config go here
return {
  {
    'tpope/vim-sleuth'
  },
  {
    -- autoclose tags
    'windwp/nvim-ts-autotag',
  },
  {
    -- detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
  },
  {
    -- Powerful Git integration for Vim
    'tpope/vim-fugitive',
  },
  {
    -- GitHub integration for vim-fugitive
    'tpope/vim-rhubarb',
  },
  {
    -- Hints keybinds
    'folke/which-key.nvim',
    opts = {
      -- win = {
      --   border = {
      --     { '┌', 'FloatBorder' },
      --     { '─', 'FloatBorder' },
      --     { '┐', 'FloatBorder' },
      --     { '│', 'FloatBorder' },
      --     { '┘', 'FloatBorder' },
      --     { '─', 'FloatBorder' },
      --     { '└', 'FloatBorder' },
      --     { '│', 'FloatBorder' },
      --   },
      -- },
    },
  },
  {
    -- Autoclose parentheses, brackets, quotes, etc.
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {},
  },
  {
    -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
  {
    -- high-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" }
    },
    opts = {
      ring = { storage = "sqlite" },
      system_clipboard = {
        sync_with_ring = true,
        -- Use xsel for clipboard integration
        provider = "xsel",
        enable_OSC52 = true, -- Use OSC52 as fallback
      },
    },
    keys = {
      { "<leader>p", "<cmd>YankyRingHistory<cr>",              mode = { "n", "x" },                                desc = "Open Yank History" },
      { "y",         "<Plug>(YankyYank)",                      mode = { "n", "x" },                                desc = "Yank text" },
      { "p",         "<Plug>(YankyPutAfter)",                  mode = { "n", "x" },                                desc = "Put yanked text after cursor" },
      { "P",         "<Plug>(YankyPutBefore)",                 mode = { "n", "x" },                                desc = "Put yanked text before cursor" },
      { "gp",        "<Plug>(YankyGPutAfter)",                 mode = { "n", "x" },                                desc = "Put yanked text after selection" },
      { "gP",        "<Plug>(YankyGPutBefore)",                mode = { "n", "x" },                                desc = "Put yanked text before selection" },
      { "<c-p>",     "<Plug>(YankyPreviousEntry)",             desc = "Select previous entry through yank history" },
      { "<c-n>",     "<Plug>(YankyNextEntry)",                 desc = "Select next entry through yank history" },
      { "]p",        "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
      { "[p",        "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
      { "]P",        "<Plug>(YankyPutIndentAfterLinewise)",    desc = "Put indented after cursor (linewise)" },
      { "[P",        "<Plug>(YankyPutIndentBeforeLinewise)",   desc = "Put indented before cursor (linewise)" },
      { ">p",        "<Plug>(YankyPutIndentAfterShiftRight)",  desc = "Put and indent right" },
      { "<p",        "<Plug>(YankyPutIndentAfterShiftLeft)",   desc = "Put and indent left" },
      { ">P",        "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P",        "<Plug>(YankyPutIndentBeforeShiftLeft)",  desc = "Put before and indent left" },
      { "=p",        "<Plug>(YankyPutAfterFilter)",            desc = "Put after applying a filter" },
      { "=P",        "<Plug>(YankyPutBeforeFilter)",           desc = "Put before applying a filter" },
    },
  }
}
