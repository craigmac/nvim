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
