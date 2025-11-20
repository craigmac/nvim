vim.bo.number = false
vim.bo.list = false
vim.bo.cursorline = false

-- see `:h global-local` for `=` vs `<` difference
vim.b.undo_ftplugin = vim.b.undo_ftplugin .. ' | setl nu< list< cul<'
