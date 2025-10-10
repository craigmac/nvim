vim.cmd.packadd('netrw')
vim.cmd.packadd('nohlsearch')

-- first clone https://github.com/savq/paq-nvim
require('paq')({
  'savq/paq-nvim',
  'tpope/vim-repeat',
  'tpope/vim-rsi',
  'tpope/vim-unimpaired',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tommcdo/vim-lion',
  'romainl/vim-qf',
  'justinmk/vim-sneak',
  'neovim/nvim-lspconfig',
  'ibhagwan/fzf-lua',
  'glacambre/firenvim', -- requires :call firenvim#install(0) after an update
  'kylechui/nvim-surround',
  'mrjones2014/smart-splits.nvim',
  'lewis6991/gitsigns.nvim',
  'catgoose/nvim-colorizer.lua',
})

