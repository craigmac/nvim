-- https://github.com/mason-org/mason.nvim
-- ~/.local/share/nvim/lazy/mason.nvim/
---@module 'lazy'
---@type LazyPluginSpec
return {
  'mason-org/mason.nvim',
  opts = {
    ui = {
      backdrop = 0, -- fully opaque, default 60
      width = 0.9, -- default 0.8
      height = 0.9, -- default 0.8
    },
  },
}
