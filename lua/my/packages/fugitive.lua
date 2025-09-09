vim.keymap.set('n', '<Leader>gg', '<Cmd>G<CR>')
vim.keymap.set('n', '<Leader>gP', '<Cmd>G push<CR>')
vim.keymap.set('n', '<Leader>gl', '<Cmd>G log %<CR>')

-- `:h fugitive-autocommands`
vim.api.nvim_create_autocmd('User', {
  pattern = 'FugitiveIndex',
  desc = 'When fugitive-summary buffer is loaded.',
  group = augroup,
  callback = function()
    vim.cmd([[norm gU]])
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'FugitiveEditor',
  callback = function()
    vim.cmd.startinsert()
  end,
  desc = 'After a :Git ... command edits a file like commit msg.'
})
