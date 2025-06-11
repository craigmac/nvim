require('conform').setup({
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
})


