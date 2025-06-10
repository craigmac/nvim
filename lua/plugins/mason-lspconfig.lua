-- https://github.com/mason-org/mason-lspconfig.nvim
-- ~/.local/share/nvim/lazy/mason-lspconfig.nvim/
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
    -- and will call the vim.lsp.enable() to enable them
    automatic_enable = false,
  },
}
