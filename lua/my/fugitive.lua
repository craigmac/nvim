local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map('n', '<Leader>gg', '<Cmd>G<CR>', opts)
map('n', '<Leader>gP', '<Cmd>G push<CR>', opts)
map('n', '<Leader>gp', '<Cmd>G pull<CR>', opts)
map('n', '<Leader>gd', '<Cmd>Gvdiffsplit<CR>', opts)
map('n', '<Leader>gb', '<Cmd>G blame<CR>', opts)
map('n', '<Leader>gl', '<Cmd>Gclog<CR>', opts)
map('n', '<Leader>gc', '<Cmd>G commit -av<CR>', opts)

