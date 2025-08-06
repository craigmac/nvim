-- nvim nightly config

vim.loader.enable()

require('my.globals')
require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.lsp')
require('my.colors')

-- runtime plugins shipped with nvim
vim.cmd.packadd('nohlsearch')

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
  -- g?o<text object> g?O, g?v<user prompt>, g?V, g?so, g?p, g?P, g?sp
  { src = 'https://github.com/andrewferrier/debugprint.nvim' },
  -- gl/gL, use gl/ to enter pattern to align on (right-align matching pattern)
  { src = 'https://github.com/tommcdo/vim-lion' },
  -- run `:call firenvim#install(0)` if this updates and on first install
  { src = 'https://github.com/glacambre/firenvim' },
}

vim.pack.add(plugins)

require('plugins.fzf-lua')
require('plugins.smart-splits')
require('plugins.nvim-surround')
-- require('plugins.colorscheme')
require('plugins.debugprint')
