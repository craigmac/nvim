-- https://github.com/stevearc/conform.nvim
-- integrates external CLI formatters (non-LSP provided formatting)
---@type LazySpec
return {
  'stevearc/conform.nvim',
  event = 'BufWritePre',
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters_by_ft = {
      python = { 'black' },
      bash = { 'shfmt' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      yaml = { 'prettier' },
    },
  },
}
