-- assembled from `highlight_group.c` in neovim source
local p = {
  black = '#07080d', -- alias for 'gray1'
  red = '#590008',
  green = '#005523',
  yellow = '#6b5300',
  blue = '#004c73',
  magenta = '#470045',
  cyan = '#007373',
  white = '#2c2e33',        -- same as 'gray3', added as alias
  bright_black = '#9b9ea4', -- same as 'gray4', added as alias
  bright_red = '#ffc0b9',
  bright_green = '#b3f6c0',
  bright_yellow = '#fce094',
  bright_blue = '#a6dbff',
  bright_magenta = '#ffcaff',
  bright_cyan = '#8cf8f7',
  bright_white = '#eef1f8', -- alias for 'bright_gray1'
  gray1 = '#07080d',
  gray2 = '#14161b',        -- bg in dark mode, fg in light mode
  gray3 = '#2c2e33',
  gray4 = '#4f5258',
  bright_gray1 = '#eef1f8',
  bright_gray2 = '#e0e2ea', -- bg in light mode, fg in dark mode
  bright_gray3 = '#c4c6cd',
  bright_gray4 = '#9b9ea4',
}

local hi = function(group, value) vim.api.nvim_set_hl(0, group, value) end

hi('Statement', { fg = p.bright_gray3, italic = true })

hi('TabLineSel', { link = 'PmenuSel' })
hi('TabLineFill', { fg = p.bright_gray2, bg = p.black })
hi('TabLineFill', { fg = '#e0e2ea', bg = '#07080d' })
hi('TabLine', { link = 'Pmenu' })

-- for use in stl, for example: `'%1*Red background and black fg text.%* Default hl again'`
hi('User1', { fg = p.black, bg = p.bright_red })
hi('User2', { fg = p.black, bg = p.bright_green })
hi('User3', { fg = p.black, bg = p.bright_yellow })
hi('User4', { fg = p.bright_white, bg = p.bright_blue })
hi('User5', { fg = p.black, bg = p.bright_magenta })
hi('User6', { fg = p.bright_white, bg = p.bright_cyan })
hi('User7', { fg = p.black, bg = p.bright_white })
