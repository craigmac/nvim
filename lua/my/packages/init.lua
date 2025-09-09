vim.cmd.packadd('netrw')
vim.cmd.packadd('nohlsearch')

-- https://github.com/savq/paq-nvim.git
require('paq')({
  'andrewferrier/debugprint.nvim',
  'glacambre/firenvim',
  'ibhagwan/fzf-lua',
  'kylechui/nvim-surround',
  'lewis6991/gitsigns.nvim',
  'mrjones2014/smart-splits.nvim',
  'neovim/nvim-lspconfig',
  'romainl/vim-qf',
  'tommcdo/vim-lion',
  'tpope/vim-repeat',
  'tpope/vim-rsi',
  'tpope/vim-unimpaired',
  'justinmk/vim-sneak',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'catgoose/nvim-colorizer.lua',
  'echasnovski/mini.completion',
  'mfussenegger/nvim-lint'
})

-- config for pre/post-install goes in my/packages/<plugin name>.lua (remove any trailing '.nvim')
require('my.packages.fzf-lua')
require('my.packages.smart-splits')
require('my.packages.nvim-lspconfig')
require('my.packages.mini-completion')
require('my.packages.gitsigns')
require('my.packages.fugitive')
require('my.packages.nvim-surround')
require('my.packages.vim-qf')
require('my.packages.vim-lion')
require('my.packages.vim-sneak')
require('my.packages.nvim-lint')
require('my.packages.firenvim')
require('my.packages.debugprint')

