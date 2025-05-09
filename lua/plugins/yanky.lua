-- -- better yank/paste
-- return {
--   "gbprod/yanky.nvim",
--   event = "VeryLazy",
--   desc = "Better Yank/Paste",
--   opts = {
--     highlight = { timer = 150 },
--   },
--   config = function()
--     require("yanky").setup({
--       highlight = { timer = 150 },
--     })
    
--     -- Setup telescope extension if available
--     local has_telescope, telescope = pcall(require, "telescope")
--     if has_telescope then
--       telescope.load_extension("yank_history")
--     end
--   end,
--   keys = {
--     {
--       "<leader>p",
--       function()
--         local has_telescope, telescope = pcall(require, "telescope")
--         if has_telescope then
--           telescope.extensions.yank_history.yank_history({})
--         else
--           vim.cmd([[YankyRingHistory]])
--         end
--       end,
--       mode = { "n", "x" },
--       desc = "Open Yank History",
--     },
--     -- stylua: ignore
--     { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
--     { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
--     { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
--     { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Selection" },
--     { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Selection" },
--     { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
--     { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
--     { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
--     { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
--     { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
--     { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
--     { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
--     { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
--     { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
--     { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
--     { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
--     { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
--   },
--   dependencies = {
--     "nvim-telescope/telescope.nvim",
--   },
-- }

-- ~/.config/nvim/lua/plugins/yanky.lua
-- Module that returns yanky.nvim configuration

return {
  "gbprod/yanky.nvim",
  dependencies = {
    -- Optional dependencies
    { "nvim-telescope/telescope.nvim" }, -- For telescope integration
  },
  event = "VeryLazy", -- Load when needed
  opts = {
    -- Ring settings
    ring = {
      history_length = 100,
      storage = vim.fn.stdpath("data") .. "/yanky",
      sync_with_numbered_registers = true,
      cancel_event = "update",
    },
    
    -- Picker settings
    picker = {
      select = {
        action = nil, -- Uses default action
      },
      
      -- Telescope integration
      telescope = {
        use_default_mappings = true,
        mappings = nil, -- Uses default mappings
      },
    },
    
    -- System clipboard integration
    system_clipboard = {
      sync_with_ring = true,
    },

    -- Highlight settings
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 300,
    },

    -- Preserve cursor position after putting text
    preserve_cursor_position = {
      enabled = true,
    },

    -- Clear history after quitting Vim
    clear_history = false,
    
    -- Text cutting behavior
    cutting = {
      sync_with_blackhole_register = true,
      sync_with_clipboard = true,
    },
  },
  config = function(_, opts)
    -- Load yanky with the options
    require("yanky").setup(opts)
    
    -- Register telescope extension if available
    pcall(require("telescope").load_extension, "yank_history")
    
    -- Setup keymaps
    local map = vim.keymap.set
    local yanky_map = "<Plug>(Yanky"
    
    -- Yank key mappings (replace default y and p operations)
    map({"n","x"}, "y", yanky_map .. "Yank)")
    map({"n","x"}, "p", yanky_map .. "PutAfter)")
    map({"n","x"}, "P", yanky_map .. "PutBefore)")
    map({"n","x"}, "gp", yanky_map .. "GPutAfter)")
    map({"n","x"}, "gP", yanky_map .. "GPutBefore)")

    -- Cycle through yank history
    map("n", "<c-n>", yanky_map .. "CycleForward)")
    map("n", "<c-p>", yanky_map .. "CycleBackward)")

    -- Telescope integration
    map("n", "<leader>y", function()
      require("telescope").extensions.yank_history.yank_history({})
    end, { desc = "Yank History" })

    -- Optional: Add the ability to put text without auto-formatting
    map("n", "<leader>yp", yanky_map .. "PutAfterNoFormat)")
    map("n", "<leader>yP", yanky_map .. "PutBeforeNoFormat)")

    -- Optional: Add the ability to put text and keep the cursor position
    map("n", "<leader>ygp", yanky_map .. "GPutAfterNoFormat)")
    map("n", "<leader>ygP", yanky_map .. "GPutBeforeNoFormat)")
    
    -- If using which-key
    if pcall(require, "which-key") then
      require("which-key").register({
        ["<leader>y"] = { name = "+yank" },
        ["<leader>yh"] = { 
          function() 
            require("telescope").extensions.yank_history.yank_history({}) 
          end, 
          "Yank History" 
        },
        ["<leader>yc"] = { "<cmd>YankyClearHistory<CR>", "Clear Yank History" },
      })
    end
  end,
}