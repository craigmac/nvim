-- https://github.com/stevearc/quicker.nvim
-- ~/.local/share/nvim/lazy/quicker.nvim/
---@type LazyPluginSpec
return {
  'stevearc/quicker.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', function() require('quicker').toggle() end)
    vim.keymap.set('n', '<Leader>l', function() require('quicker').toggle({ loclist = true }) end)
  end,
  ---@type quicker.SetupOptions
  opts = {},
}
