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

-- for use in `:h 'stl` format strings -> %1*<User1 hl applied: black fg on red bg>%*<colors reset>
local hi = function(group, value) vim.api.nvim_set_hl(0, group, value) end
if vim.o.background == 'dark' then
  hi('User1', { fg = 'Black', bg = 'LightRed' })
  hi('User2', { fg = 'Black', bg = 'LightGreen' })
  hi('User3', { fg = 'Black', bg = 'LightYellow' })
  hi('User4', { fg = 'Black', bg = 'LightBlue' })
  hi('User5', { fg = 'Black', bg = 'LightMagenta' })
  hi('User6', { fg = 'Black', bg = 'LightCyan' })
  hi('User7', { fg = 'Black', bg = 'White' })
else -- darker variants for light bg need brighter fg for contrast
  hi('User1', { fg = 'White', bg = 'Red' })
  hi('User2', { fg = 'White', bg = 'Green' })
  hi('User3', { fg = 'White', bg = 'Yellow' })
  hi('User4', { fg = 'White', bg = 'Blue' })
  hi('User5', { fg = 'White', bg = 'Magenta' })
  hi('User6', { fg = 'White', bg = 'Cyan' })
  hi('User7', { fg = 'White', bg = 'LightGrey' })
end

-- technically there are 9 supported so let's make 8/9 dark-mode and light-mode
hi('User8', { fg = 'White', bg = 'Black' })
hi('User9', { fg = 'Black', bg = 'White' })

-- local hi = function(group, value) vim.api.nvim_set_hl(0, group, value) end
-- fixes to various colorschemes, pattern is matched against colorscheme name
local id = vim.api.nvim_create_augroup('my.augroup.colorscheme', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = id,
  pattern = '*',
  desc = 'Set tweaks to colors depending on colorscheme',
  callback = function(ev)
    -- highlight overrides for every colorscheme
    vim.api.nvim_set_hl(0, 'CurSearch', { link = 'IncSearch' })

    -- specific colorschemes
    if ev.data.match == 'default' then
      if vim.o.background == 'dark' then
      end
    end
  end,



})
