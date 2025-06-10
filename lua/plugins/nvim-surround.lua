-- https://github.com/kylechui/nvim-surround
-- ~/.local/share/nvim/lazy/nvim-surround/
---@type LazyPluginSpec
return {
  'kylechui/nvim-surround',
  event = 'InsertEnter', -- so `<C-g>s` in insert mode is available if not loaded yet
  keys = { 'cs', 'ys', 'ds', 'S' },
  opts = {},
}
