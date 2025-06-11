local pkgs = {
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', branch = 'main' },
  { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  'neovim/nvim-lspconfig',
  'ibhagwan/fzf-lua',
  'mrjones2014/smart-splits.nvim',
  'stevearc/conform.nvim',
  'lewis6991/gitsigns.nvim',
  'HoNamDuong/hybrid.nvim',
  'mbbill/undotree',
  'mfussenegger/nvim-lint',
  'mason-org/mason.nvim',
  'kylechui/nvim-surround',
  'stevearc/quicker.nvim',
  'tpope/vim-rsi',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

}

-- hand our list to a package manager to do the installing
require('paq')(pkgs)

require('plugins.conform')
require('plugins.fzf')
require('plugins.gitsigns')
require('plugins.hybrid')
require('plugins.lint')
require('plugins.mason')
require('plugins.surround')
require('plugins.quicker')
require('plugins.splits')
require('plugins.treesitter-textobjects')
require('plugins.fugitive')
