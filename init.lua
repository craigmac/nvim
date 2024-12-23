-- vi: et tw=100 sw=2 sts=-1
vim.g.mapleader = " "

vim.loader.enable()

-- `gf` to jump to file location
require('user.rocks')
require('user.options')
require('user.autocmds')
require('user.commands')
require('user.keymaps')
require('user.lsp')
