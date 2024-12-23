-- https://github.com/lewis6991/gitsigns.nvim
-- :Gitsigns<CR> to choose, or :Gitsigns <Tab> for completes
local gitsigns = require('gitsigns')

gitsigns.setup({
  preview_config = {
    border = 'rounded'
  },
})

-- toggle (g)itsigns
vim.keymap.set('n', 'yog', '<Cmd>Gitsigns toggle_signs<CR>')

vim.keymap.set('n', '[h', '<Cmd>Gitsigns prev_hunk<CR>')
vim.keymap.set('n', ']h', '<Cmd>Gitsigns next_hunk<CR>')
-- hu, hs, hb
vim.keymap.set('n', '<Leader>hs', '<Cmd>Gitsigns stage_hunk<CR>')
vim.keymap.set('n', '<Leader>hS', '<Cmd>Gitsigns stage_buffer<CR>')
vim.keymap.set('n', '<Leader>hu', '<Cmd>Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', '<Leader>hb', '<Cmd>Gitsigns blame_line<CR>')
-- vim.keymap.set('n', '<Leader>hp', '<Cmd>Git

gitsigns.toggle_signs()
