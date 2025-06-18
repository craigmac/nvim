---@type vim.pack.Spec[]
local pkgs = {
  'https://github.com/neovim/nvim-lspconfig',
  {
    source = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main'
  },
  {
    source = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    version = 'main'
  },
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/mrjones2014/smart-splits.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/HoNamDuong/hybrid.nvim',
  'https://github.com/mbbill/undotree',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/stevearc/quicker.nvim',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/tommcdo/vim-lion',
}

vim.pack.add(pkgs)

vim.api.nvim_create_autocmd('PackUpdate', {
  group = vim.api.nvim_create_augroup('my.augroup.pack', {}),
  command = 'TSUpdate',
  desc = 'Run `:TSUpdate` when vim.pack updates, in case nvim-treesitter plugin needs it.'
})

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
