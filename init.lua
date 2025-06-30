-- nvim nightly config

My = {}

require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.lsp')

---[[ experimental
vim.loader.enable()

require('vim._extui').enable({ enable = true, msg = { target = 'msg', timeout = 4000 } })

vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/mrjones2014/smart-splits.nvim',
  'https://github.com/HoNamDuong/hybrid.nvim',
  'https://github.com/mfussenegger/nvim-lint',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/tpope/vim-endwise',
  'https://github.com/romainl/vim-cool',
  'https://github.com/romainl/vim-qf',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/tommcdo/vim-lion',
})
require('plugins.fzf-lua')
require('plugins.smart-splits')
require('plugins.nvim-surround')
require('plugins.colorscheme')
require('plugins.conform')
require('plugins.lint')
require('plugins.vim-qf')
--]]
