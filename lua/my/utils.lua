local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
