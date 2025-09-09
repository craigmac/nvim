local lint = require('lint')

lint.linters_by_ft = {
  -- lua = { 'selene' },
  bash = { 'shellcheck' },
  -- markdown = { 'vale' }, -- needs a vale.ini file setup
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
  group = vim.api.nvim_create_augroup('my.augroup.lint', { clear = true }),
  callback = function()
    if vim.bo.modifiable then lint.try_lint() end
  end,
})
