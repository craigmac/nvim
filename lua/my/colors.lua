vim.cmd.colorscheme('habamax')

vim.cmd([[
hi! VertSplit guibg=bg guifg=fg
" rm bg/fg and let term emulator handle those
" to provide more integrated feel with
hi! Normal guibg=NONE ctermbg=NONE
" [~])j
]])
