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
  
  -- plugins
  -- require('plugins.alpha'),
  -- require('plugins.aerial'),
  -- require('plugins.autocompletion'),
  -- require('plugins.avante'),
  -- require('plugins.bufferline'),
  -- require('plugins.chatgpt'),
  -- require('plugins.comment'),
  -- require('plugins.database'),
  -- require('plugins.debug'),
  -- require('plugins.gitsigns'),
  -- require('plugins.harpoon'),
  -- require('plugins.indent-blankline'),
  -- require('plugins.lazygit'),
  -- require('plugins.lsp'),
  -- require('plugins.lualine'),
  -- require('plugins.misc'),
  -- require('plugins.neo-tree'),
  -- require('plugins.none-ls'),
  
  -- require('plugins.telescope'),
  -- require('plugins.treesitter'),
  -- require('plugins.vim-tmux-navigator'),
})
