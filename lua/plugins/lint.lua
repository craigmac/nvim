-- https://github.com/mfussenegger/nvim-lint
-- ~/.local/share/nvim/lazy/nvim-lint/
-- Integrate external CLI linters (non-LSP provided linting)
---@type LazyPluginSpec
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {
      lua = { 'selene' },
      -- markdown = { 'vale' }, -- needs a vale.ini file setup
      -- text = { 'vale' },
      bash = { 'shellcheck' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('my.augroup.lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
      group = lint_augroup,
      callback = function()
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}
