-- https://github.com/HoNamDuong/hybrid.nvim
---@type LazySpec
return {
  'HoNamDuong/hybrid.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    italics = {
      strings = false,
      emphasis = false,
      comments = false,
      folds = false,
    },
  },
  config = function()
    vim.cmd.colorscheme('hybrid')
  end,
}
