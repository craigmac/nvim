require('notify').setup({
  stages = 'slide',
})

-- monkey patch to point to nvim-notify implementation
vim.notify = require('notify')
