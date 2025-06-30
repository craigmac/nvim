-- open current item in (s)plit, (v)ertical, (t)ab, (o)pen and come back,
-- (O)pen and close loc/qf window, (p)review
vim.g.qf_mapping_ack_style = 1

vim.keymap.set('n', '<Leader>q', '<Plug>(qf_qf_toggle)')
vim.keymap.set('n', '<Leader>l', '<Plug>(qf_loc_toggle)')

vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', ':.Reject<CR>', { buffer = true })
    vim.keymap.set('x', 'd', ':Reject<CR>', { buffer = true })
  end,
})
