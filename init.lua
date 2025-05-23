require('config.options')
require('config.keymaps')
require('config.snippets')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- themes
  require('plugins.nord'),
  require('plugins.onedark'),
  require('plugins.colorscheme'),

  require('plugins.lualine'),
  require('plugins.treesitter'),
  require('plugins.aerial'),
  require('plugins.alpha'),
  require('plugins.telescope'),
  require('plugins.neo-tree'),
  require('plugins.indent-blankline'),
  require('plugins.none-ls'),
  require('plugins.autocompletion'),
  require('plugins.lsp'),
  require('plugins.bufferline'),
  require('plugins.comment'),
  require('plugins.lazygit'),
  require('plugins.gitsigns'),
  require('plugins.database'),
  require('plugins.debug'),
  require('plugins.harpoon'),
  require('plugins.misc'),
  require('plugins.autoformat'),

  -- plugins
  -- require('plugins.avante'),
  -- require('plugins.chatgpt'),
  -- require('plugins.vim-tmux-navigator'),

}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
