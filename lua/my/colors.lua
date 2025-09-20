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

-- small transparency effect on popupmenus, PmenuSel by default sets to 0.
vim.o.pumblend = 5
-- small transparency on floating windows
vim.o.winblend = 5

-- default bg #07080d (black aka gray1) doesn't work well when you use border characters,
-- as it 'bleeds' beyond the border char boundaries
hi('NormalFloat', { link = 'Normal' })

-- this will not work well when terminal emulator cursor is set to reverse-video
-- but it makes it way more obvious and works in visual mode too.
hi('MatchParen', { reverse = true })

-- default links to StatusLine, gives ugly black horizontal line on white bg
hi('MsgSeparator', { fg = p.bright_gray2 })

-- switch from bold and NvimLightGrey3 (normal fg in dark-mode), to a brighter white
hi('Statement', { fg = p.bright_gray1 })

-- default doesn't match either PmenuSel or StatusLine, I'd rather it be consistent
-- with at least one of them
hi('TabLineSel', { link = 'PmenuSel' })
-- hi('TabLineFill', { link = 'Pmenu' })
hi('TabLine', { link = 'Pmenu' })

-- default is: cterm=underline gui=underline
-- blue like html links
hi('Underlined', { underline = true, fg = p.bright_blue, sp = p.bright_blue })

-- for use in statusline format strings, for example: `'%1*<text goes here>%*'`
hi('User1', { fg = p.black, bg = p.bright_red })
hi('User2', { fg = p.black, bg = p.bright_green })
hi('User3', { fg = p.black, bg = p.bright_yellow })
hi('User4', { fg = p.black, bg = p.bright_blue })
hi('User5', { fg = p.black, bg = p.bright_magenta })
hi('User6', { fg = p.black, bg = p.bright_cyan })
hi('User7', { fg = p.black, bg = p.bright_white })

hi('WinSeparator', { fg = p.gray3 })

-- Based on Alacritty (>=0.13) default colorscheme.
--
-- Alacritty <0.12 used 'Tomorrow Night' as default, but in 0.13 it
-- switched to 'Default Dark' by Chris Kempson, but added brighter
-- versions of the 1-6 indexes for the 9-14 colour indexes, whereas
-- Kempson's did not (1-6 and 9-14 colours were the same).
--
-- From:
-- https://github.com/alacritty/alacritty/blob/9f8fed7c9e76b013f8c2632105d1abec18e6a64e/alacritty/src/config/color.rs#L228
--
-- "generated with oklab by multiplying brightness by 1.12 and then adjusting numbers to make them
--  look 'nicer'. Yellow color was generated the same way, however the first SRGB representable
--  colour was picked."
-- vim.g.terminal_color_0 = '#181818'
-- vim.g.terminal_color_1 = '#ab4642'
-- vim.g.terminal_color_2 = '#a1b56c'
-- vim.g.terminal_color_3 = '#f7ca88'
-- vim.g.terminal_color_4 = '#7cafc2'
-- vim.g.terminal_color_5 = '#ba8baf'
-- vim.g.terminal_color_6 = '#85c1b9'
-- vim.g.terminal_color_7 = '#d8d8d8'
-- vim.g.terminal_color_8 = '#6b6b6b'
-- vim.g.terminal_color_9 = '#c55555'
-- vim.g.terminal_color_10 = '#aac474'
-- vim.g.terminal_color_11 = '#feca88'
-- vim.g.terminal_color_12 = '#82b8c8'
-- vim.g.terminal_color_13 = '#c28cb8'
-- vim.g.terminal_color_14 = '#93d3c3'
-- vim.g.terminal_color_15 = '#f8f8f8'
