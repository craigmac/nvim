
vim.cmd([[
  " default link to Statement is just bold and hard to spot diff line markers quickly,
  " instead make them cyan like lazygit does
  hi! diffLine guifg=cyan
  hi! TermCursor gui=none guibg=lightreg guifg=white
]])
