-- https://github.com/tpope/vim-unimpaired
-- ~/.local/share/nvim/lazy/vim-unimpaired/
---@module 'lazy'
---@type LazyPluginSpec
return {
  'tpope/vim-unimpaired',
  dependencies = 'tpope/vim-repeat',
  event = 'VeryLazy',
}
