-- https://github.com/mrjones2014/smart-splits.nvim
local splits = require('smart-splits')
splits.setup()

vim.keymap.set("n", "<C-M-h>", splits.resize_left)
vim.keymap.set("n", "<C-M-j>", splits.resize_down)
vim.keymap.set("n", "<C-M-k>", splits.resize_up)
vim.keymap.set("n", "<C-M-l>", splits.resize_right)
vim.keymap.set("n", "<M-h>", splits.move_cursor_left)
vim.keymap.set("n", "<M-j>", splits.move_cursor_down)
vim.keymap.set("n", "<M-k>", splits.move_cursor_up)
vim.keymap.set("n", "<M-l>", splits.move_cursor_right)
vim.keymap.set("n", "<M-p>", splits.move_cursor_previous)