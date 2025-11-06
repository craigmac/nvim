-- nvim nightly config

require 'my.experimental'
require 'my.settings'
require 'my.autocmds'
require 'my.keymaps'
require 'my.commands'
require 'my.lsp'
if vim.fn.has('gui_running') == 1 then require 'my.gui' end

-- BUG: https://github.com/neovim/neovim/issues/36416
vim.api.nvim_create_autocmd('OptionSet', { pattern = 'background', command = "lua require 'my.colors'" })

-- put configurations for these in `./after/plugins`, so plugin runtimes have been sourced
vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/mrjones2014/smart-splits.nvim',
  -- $VIMRUNTIME/lua/vim/_defaults.lua did not implement: `>p` `=p` (and variants), `yo<key>`,  `]e` `[e`
  'https://github.com/tpope/vim-unimpaired',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/tommcdo/vim-lion',
  'https://github.com/glacambre/firenvim',
  'https://github.com/romainl/vim-qf',
  'https://github.com/lewis6991/gitsigns.nvim',
})
vim.cmd.packadd 'nohlsearch'

