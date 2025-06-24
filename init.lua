-- nvim nightly config

-- reserve a namespace on the global table
My = {}

require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.lsp')

require('plugins.init')

-- ⚠ experimental ⚠
vim.loader.enable()

-- ⚠ experimental ⚠
require('vim._extui').enable({ enable = true, msg = { target = 'msg', timeout = 4000 }})
