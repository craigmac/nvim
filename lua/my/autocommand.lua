vim.cmd [[
augroup my_autocommands
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup END
]]
