require('quicker').setup()
vim.keymap.set('n', '<Leader>q', function() require('quicker').toggle() end)
vim.keymap.set('n', '<Leader>l', function() require('quicker').toggle({ loclist = true }) end)


