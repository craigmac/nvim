vim.wo.number = false
vim.wo.list = false
vim.wo.cursorline = false

-- see `:h global-local` for `=` vs `<` difference
vim.b.undo_ftplugin = vim.b.undo_ftplugin .. ' | setl nu< list< cul<'
