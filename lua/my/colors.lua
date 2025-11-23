-- assembled from `highlight_group.c` in neovim source
local p = {
  black = "#07080d", -- alias for 'gray1'
  red = "#590008",
  green = "#005523",
  yellow = "#6b5300",
  blue = "#004c73",
  magenta = "#470045",
  cyan = "#007373",
  white = "#2c2e33", -- same as 'gray3', added as alias
  bright_black = "#9b9ea4", -- same as 'gray4', added as alias
  bright_red = "#ffc0b9",
  bright_green = "#b3f6c0",
  bright_yellow = "#fce094",
  bright_blue = "#a6dbff",
  bright_magenta = "#ffcaff",
  bright_cyan = "#8cf8f7",
  bright_white = "#eef1f8", -- alias for 'bright_gray1'
  gray1 = "#07080d",
  gray2 = "#14161b", -- bg in dark mode, fg in light mode
  gray3 = "#2c2e33",
  gray4 = "#4f5258",
  bright_gray1 = "#eef1f8",
  bright_gray2 = "#e0e2ea", -- bg in light mode, fg in dark mode
  bright_gray3 = "#c4c6cd",
  bright_gray4 = "#9b9ea4",
}

-- 'notgc' + &pumblend|&winblend > 0 breaks the UI. we use autogroup `my.augroup.optionset` to adjust.
vim.o.pumblend = vim.o.termguicolors and 10 or 0
vim.o.winblend = vim.o.termguicolors and 10 or 0

-- using this requires we set something sensible for fillchar 'msgsep' to show split
vim.api.nvim_set_hl(0, "MsgSeparator", { link = "Normal" })

-- set 'winborder' so we can see the outline of the window
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "Float", { link = "Normal" })

if vim.o.background == "light" then
  -- some default colours like `NvimDark[Blue|Green]` are too dark to distinguish between them when applied to
  -- smaller symbols/areas against a light background, like gitsigns markers. fix by picking
  -- non-default palette colours that are more obvious.
  vim.api.nvim_set_hl(0, "Added", { fg = "Green" })
  vim.api.nvim_set_hl(0, "Changed", { fg = "Orange" })
  vim.api.nvim_set_hl(0, "Removed", { fg = "Red" })
end

-- use `NvimLight*` colours for `User1..9` because they are used against a dark statusline
-- background, stl is dark even in light mode. `NvimDark*` colours are hard to see against dark backgrounds.
vim.api.nvim_set_hl(0, "User1", { fg = p.bright_black })
vim.api.nvim_set_hl(0, "User2", { fg = p.bright_red })
vim.api.nvim_set_hl(0, "User3", { fg = p.bright_green })
vim.api.nvim_set_hl(0, "User4", { fg = p.bright_yellow })
vim.api.nvim_set_hl(0, "User5", { fg = p.bright_blue })
vim.api.nvim_set_hl(0, "User6", { fg = p.bright_magenta })
vim.api.nvim_set_hl(0, "User7", { fg = p.bright_cyan })
vim.api.nvim_set_hl(0, "User8", { fg = p.bright_white })
