if not vim.o.termguicolors then
  -- default links for these are to terminal foreground colour, making them hard to distinguish.
  -- 8 is not guaranteed to be 'light/bright black' but defacto standardish.
  vim.api.nvim_set_hl(0, 'Comment', { ctermfg = 8, ctermbg = 'NONE' })
  vim.api.nvim_set_hl(0, 'NonText', { ctermfg = 8, ctermbg = 'NONE' })

  -- default link to Statement is just bold and hard to spot diff line markers quickly.
  -- instead make them cyan like lazygit does
  vim.api.nvim_set_hl(0, 'diffLine', { ctermfg = 14, ctermbg = 'NONE' })

  -- default is same as Search, that can make it hard to determine which result you're on
  -- especially if you've got a reverse cursor
  vim.api.nvim_set_hl(0, 'CurSearch', { ctermfg = 0, ctermbg = 13 })

  -- UI/Menus/Lines/Bars
  vim.api.nvim_set_hl(0, 'Pmenu', { ctermfg = 0, ctermbg= 7 })
  vim.api.nvim_set_hl(0, 'PmenuSel', { ctermfg = 0, ctermbg= 13 })
  vim.api.nvim_set_hl(0, 'PmenuThumb', { ctermfg = 0, ctermbg = 8 })
  -- underlined no-bg default is poor choice, let's use colour
  vim.api.nvim_set_hl(0, 'StatusLineNC', { ctermfg = 0, ctermbg = 8 })
  -- default is reverse, adjust explicitly to be brighter than StatusLineNC
  vim.api.nvim_set_hl(0, 'StatusLine', { ctermfg = 0, ctermbg = 15 })
  -- Do away with underlined stuff - use colours instead
  vim.api.nvim_set_hl(0, 'CursorLine', { ctermbg = 0 })
  vim.api.nvim_set_hl(0, 'MatchParen', { reverse = true, ctermbg = 13, ctermfg = 0 })
  -- the non-current tabpage
  vim.api.nvim_set_hl(0, 'TabLine', { ctermbg = 0, ctermfg = 8 })
  -- the tabline area from end of last tabpage to the end of the tabline
  vim.api.nvim_set_hl(0, 'TabLineFill', { ctermbg = 0 })
  -- brightwhite instead of fg and underlined
  vim.api.nvim_set_hl(0, 'TabLineSel', { ctermfg = 15 })
  -- remove bold and use brightmagenta
  vim.api.nvim_set_hl(0, 'Title', { ctermfg = 13 })
end
