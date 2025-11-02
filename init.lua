-- nvim nightly config

require 'my.experimental'
require 'my.options'
require 'my.autocmds'
require 'my.keymaps'
require 'my.commands'
-- BUG: https://github.com/neovim/neovim/issues/36416
vim.api.nvim_create_autocmd('OptionSet', { pattern = 'background', command = "lua require 'my.colors'" })

-- runtime plugins shipped with nvim
vim.cmd.packadd 'nohlsearch'

-- configs go in `./plugins` and are loaded after this file
vim.pack.add {
  'https://github.com/neovim/nvim-lspconfig',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/mrjones2014/smart-splits.nvim',
  -- $VIMRUNTIME/lua/vim/_defaults.lua did not implement: `>p` `=p` (and variants), `yo<key>`,  `]e` `[e`
  'https://github.com/tpope/vim-unimpaired',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/tpope/vim-rsi',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/tommcdo/vim-lion',
  'https://github.com/glacambre/firenvim',
  'https://github.com/romainl/vim-qf',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/ggandor/leap.nvim',
}

-- TODO: add Enter and Backspace as aliases to these on lspattach
-- vim.keymap.set('x', 'an', function()
--   vim.lsp.buf.selection_range(vim.v.count1)
-- end, { desc = 'vim.lsp.buf.selection_range(vim.v.count1)' })

-- vim.keymap.set('x', 'in', function()
--   vim.lsp.buf.selection_range(-vim.v.count1)
-- end, { desc = 'vim.lsp.buf.selection_range(-vim.v.count1)' })

