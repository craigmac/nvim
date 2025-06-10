-- nvim nightly config

require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.lsp')
require('my.plugins')

-- experimental
-- TODO: issue with long filenames?
vim.loader.enable()

require('vim._extui').enable({
  enable = true,
  msg = {
    pos = 'box'
  }
})

-- TODO: don't diagnose library files when opened
-- TODO: findprg and leader f/b mappings
-- TODO: post PackUpdate run :TSUpdate?
