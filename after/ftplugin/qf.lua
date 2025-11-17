vim.o.number = false
vim.o.list = false
vim.o.cursorline = false

vim.cmd([[
let b:undo_ftplugin = "set nu< list< cursorline<"
]])
