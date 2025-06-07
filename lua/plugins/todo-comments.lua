-- https://github.com/folke/todo-comments.nvim
--
---@type LazyPluginSpec
return {
  'folke/todo-comments.nvim',
  enabled = false,
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
}
