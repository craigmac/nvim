-- https://github.com/stevearc/quicker.nvim
-- ~/.local/share/nvim/lazy/quicker.nvim/
---@module 'lazy'
---@type LazyPluginSpec
return {
  'stevearc/quicker.nvim',
  event = 'FileType qf',
  keys = {
    {
      '<leader>q',
      function()
        require('quicker').toggle()
      end,
    },
    {
      '<leader>l',
      function()
        require('quicker').toggle({ loclist = true })
      end,
    },
  },
  ---@module 'quicker'
  ---@type quicker.SetupOptions
  opts = {},
}
