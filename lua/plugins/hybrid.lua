vim.cmd.colorscheme('hybrid')

vim.cmd([[
  " turn off the highlighted bg effect in help docs
  hi! @markup.raw.block guibg=NONE
  hi! @markup.raw guibg=NONE

  hi! StatusLineRecording ctermbg=black ctermfg=red guibg=#272a2e guifg=#d54e53
  "hi! CursorLine guibg=NONE
  "hi! CursorLineNr guibg=NONE
  hi! link TabLine StatusLineNC
  hi! link TabLineFill StatusLineNC

  " match some of the vim-hybrid original values:
  hi! StatusLine gui=reverse guifg=#707880 guibg=#1d1f21
  hi! StatusLineNC gui=reverse guifg=#303030 guibg=#707880
  hi! CursorLineNr guifg=#f0c674
  hi! Title guifg=#f0c674

  " turns off any pumblend on selected entry
  hi! PmenuSel blend=0
  hi! Comment gui=NONE

  hi! link PmenuMatch Title
  hi! link MsgSeparator Normal

  " otherwise the cells of drawn borders have black bg
  hi! FloatBorder guibg=NONE
]])
