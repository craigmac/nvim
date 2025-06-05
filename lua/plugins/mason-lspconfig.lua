-- https://github.com/mason-org/mason-lspconfig.nvim
-- ~/.local/share/nvim/lazy/mason-lspconfig.nvim/
---@module 'lazy'
---@type LazyPluginSpec
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    "mason-org/mason.nvim",
    -- just needs to be in runtimepath
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- NOTE: only enables servers installed by mason.nvim plugin
    automatic_enable = {}
  },
}
