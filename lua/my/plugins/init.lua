return {
  'tpope/vim-dispatch',
  'tpope/vim-endwise',
  'tpope/vim-repeat',
  'tpope/vim-rhubarb',
  'tpope/vim-rsi',
  'tpope/vim-unimpaired',
  'neovim/nvim-lspconfig',
  { 'kylechui/nvim-surround', opts = {} },
  { 'tommcdo/vim-lion', init = function() vim.g.lion_squeeze_spaces = 1 end },
}
