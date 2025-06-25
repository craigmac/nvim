local pkgs = {
  -- community-maintained `lsp/<lsp-servername>.lua` config files
  'https://github.com/neovim/nvim-lspconfig',
  -- `:TSInstall`, `:TSUpdate`, and ability to auto-install parsers for each ft if missing
  { source = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  -- community-maintained treesitter query files (`textobjects.scm`) for various languages
  { source = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/mrjones2014/smart-splits.nvim',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/HoNamDuong/hybrid.nvim',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/tpope/vim-endwise',
  'https://github.com/romainl/vim-cool',
  'https://github.com/romainl/vim-qf',
}
vim.pack.add(pkgs)

vim.api.nvim_create_autocmd('PackUpdate', {
  group = vim.api.nvim_create_augroup('my.augroup.pack', {}),
  command = 'TSUpdate',
  desc = 'Run `:TSUpdate` when vim.pack updates, in case nvim-treesitter plugin needs it.'
})

require('plugins.fzf')
require('plugins.mini')
require('plugins.hybrid')
require('plugins.splits')
require('plugins.conform')
require('plugins.lint')
require('plugins.mason')
require('plugins.vim-qf')
