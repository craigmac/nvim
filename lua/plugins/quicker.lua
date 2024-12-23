-- https://github.com/stevearc/quicker.nvim
local quicker = require('quicker')

vim.keymap.set("n", "<Leader>q", function() require("quicker").toggle() end)
vim.keymap.set("n", "<leader>l", function() require("quicker").toggle({ loclist = true }) end )

quicker.setup({
  keys = {
    {
      ">",
      function()
        require("quicker").expand({
          before = 2,
          after = 2,
          add_to_existing = true,
        })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function() require("quicker").collapse() end,
      desc = "Collapse quickfix context",
    },
  },
})



