local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

-- might have to remove neovim default C-l binding to use for tmux navigation plugin,
-- map('', '<C-l>', '<Nop>', opts)
map('n', '<Leader>w', ':update<CR>', opts)
map('n', '<Leader>,', ':edit ~/.config/nvim/init.lua<CR>', opts)
map('n', ']q', ':cnext<CR>', opts)
map('n', ']Q', ':clast<CR>', opts)
map('n', '[q', ':cprevious<CR>', opts)
map('n', '[Q', ':cfirst<CR>', opts)
map('n', ']l', ':lnext<CR>', opts)
map('n', ']L', ':llast<CR>', opts)
map('n', '[l', ':lprevious<CR>', opts)
map('n', '[L', ':lfirst<CR>', opts)
