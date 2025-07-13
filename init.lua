-- nvim nightly config

vim.loader.enable()

require('my.globals')
require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.lsp')

-- runtime plugins shipped with nvim
vim.cmd.packadd('nohlsearch')
vim.cmd.packadd('cfilter')

---@type vim.pack.Spec[]
local plugins = {
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/mrjones2014/smart-splits.nvim' },
  { src = 'https://github.com/tpope/vim-rsi' },
  { src = 'https://github.com/tpope/vim-endwise' },
  { src = 'https://github.com/tpope/vim-unimpaired' },
  { src = 'https://github.com/tpope/vim-repeat' },
  { src = 'https://github.com/tpope/vim-dispatch' },
  { src = 'https://github.com/kylechui/nvim-surround' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/HoNamDuong/hybrid.nvim' },
  -- g? operator
  { src = 'https://github.com/andrewferrier/debugprint.nvim' },
  -- gl/gL align operator
  { src = 'https://github.com/tommcdo/vim-lion' },
  { src = 'https://github.com/glacambre/firenvim' },
}

vim.pack.add(plugins)

-- installs integration for detected browsers
vim.fn['firenvim#install'](0)

require('plugins.fzf-lua')
require('plugins.smart-splits')
require('plugins.nvim-surround')
require('plugins.colorscheme')

