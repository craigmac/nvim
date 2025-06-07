-- https://github.com/stevearc/quicker.nvim
-- ~/.local/share/nvim/lazy/quicker.nvim/
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
  ---@type quicker.SetupOptions
  opts = {},
}
