-- nvim nightly config

vim.loader.enable()

require('my.globals')
require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.colors')

-- runtime plugins shipped with nvim
vim.cmd.packadd('nohlsearch')

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/mrjones2014/smart-splits.nvim',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/tpope/vim-endwise',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-unimpaired',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tpope/vim-dispatch',
  'https://github.com/kylechui/nvim-surround',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/andrewferrier/debugprint.nvim',
  'https://github.com/tommcdo/vim-lion',
  -- run `:call firenvim#install(0)` if this updates and on first install
  'https://github.com/glacambre/firenvim',
  'https://github.com/romainl/vim-qf',
  'https://github.com/lewis6991/gitsigns.nvim',
})

require('my.plugins.fzf-lua')
require('my.plugins.smart-splits')
require('my.plugins.nvim-surround')
require('my.plugins.debugprint')
require('my.plugins.nvim-treesitter-textobjects')
require('my.plugins.gitsigns')
require('my.plugins.fugitive')
require('my.plugins.vim-qf')
