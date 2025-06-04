-- https://github.com/stevearc/quicker.nvim
---@type LazySpec
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
