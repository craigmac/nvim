local ok, splits = pcall(require, 'smart-splits')
if not ok then return end

splits.setup()

vim.keymap.set({ 'n', 't' },'<M-H>', splits.resize_left)
vim.keymap.set({ 'n', 't' },'<M-J>', splits.resize_down)
vim.keymap.set({ 'n', 't' },'<M-K>', splits.resize_up)
vim.keymap.set({ 'n', 't' },'<M-L>', splits.resize_right)
vim.keymap.set({ 'n', 't' },'<M-h>', splits.move_cursor_left)
vim.keymap.set({ 'n', 't' },'<M-j>', splits.move_cursor_down)
vim.keymap.set({ 'n', 't' },'<M-k>', splits.move_cursor_up)
vim.keymap.set({ 'n', 't' },'<M-l>', splits.move_cursor_right)
vim.keymap.set({ 'n', 't' },'<M-p>', splits.move_cursor_previous)
