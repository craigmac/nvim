-- assembled from `highlight_group.c` in neovim source
local p = {
    black =          '#07080d', -- alias for 'gray1'
    red =            '#590008',
    green =          '#005523',
    yellow =         '#6b5300',
    blue =           '#004c73',
    magenta =        '#470045',
    cyan =           '#007373',
    white =          '#2c2e33', -- same as   'gray3', added as alias
    bright_black =   '#9b9ea4', -- same as   'gray4', added as alias
    bright_red =     '#ffc0b9',
    bright_green =   '#b3f6c0',
    bright_yellow =  '#fce094',
    bright_blue =    '#a6dbff',
    bright_magenta = '#ffcaff',
    bright_cyan =    '#8cf8f7',
    bright_white =   '#eef1f8', -- alias for 'bright_gray1'
    gray1 =          '#07080d',
    gray2 =          '#14161b', -- bg in dark mode, fg in light mode
    gray3 =          '#2c2e33',
    gray4 =          '#4f5258',
    bright_gray1 =   '#eef1f8',
    bright_gray2 =   '#e0e2ea', -- bg in light mode, fg in dark mode
    bright_gray3 =   '#c4c6cd',
    bright_gray4 =   '#9b9ea4',
}

vim.o.pumblend = 10

local hi = function(group, value) vim.api.nvim_set_hl(0, group, value) end

-- using this requires we set something sensible for fillchar 'msgsep' to show split
hi('MsgSeparator', { link = 'Normal' })

-- set 'winborder' so we can see the outline of the window
hi('NormalFloat', { link =  'Normal' })
hi('Float', { link =  'Normal' })

-- with 'list' option on, this hides the characters until selected or cursorline on
if vim.o.background == 'light' then
  hi('NonText', { fg = 'NvimLightGrey2' })
  -- defaults for these use NvimDark* which are too dark for small symbols/areas to be distinct
  -- like gitsigns in gutter
  hi('Added', { fg = 'Green' })
  hi('Changed', { fg = 'Orange' })
  hi('Removed', { fg = 'Red' })
  -- use NvimLight* 8-15 indexes here because they are used against dark statusline
  -- and so the NvimDark* 0-7 are nearly invisible againt the NvimDarkGrey3 (statusline bg)
  hi('User1', { fg = p.bright_black })
  hi('User2', { fg = p.bright_red })
  hi('User3', { fg = p.bright_green })
  hi('User4', { fg = p.bright_yellow })
  hi('User5', { fg = p.bright_blue })
  hi('User6', { fg = p.bright_magenta })
  hi('User7', { fg = p.bright_cyan })
  hi('User8', { fg = p.bright_white })
else
  hi('NonText', { fg = 'NvimDarkGrey2' })
  hi('User1', { fg = p.black })
  hi('User2', { fg = p.red })
  hi('User3', { fg = p.green })
  hi('User4', { fg = p.yellow })
  hi('User5', { fg = p.blue })
  hi('User6', { fg = p.magenta })
  hi('User7', { fg = p.cyan })
  hi('User8', { fg = p.white })
end

