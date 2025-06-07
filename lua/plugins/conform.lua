-- https://github.com/stevearc/conform.nvim
-- ~/.local/share/nvim/lazy/conform.nvim/
-- integrates external CLI formatters (non-LSP provided formatting)
---@type LazyPluginSpec
return {
  'stevearc/conform.nvim',
  cmd = 'ConformInfo',
  event = 'BufWritePre',
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    default_format_opts = {
      quiet = true,
      timeout_ms = 1000,
      lsp_format = 'never',
    },
    formatters_by_ft = {
      python = { 'black' },
      bash = { 'shfmt' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      -- yaml = { 'prettier' },
      -- json = { 'prettier' },
    },
  },
}
