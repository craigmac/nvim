-- vi: et tw=100 sw=2 sts=-1
vim.g.mapleader = " "

vim.loader.enable()

-- `gf` to jump to file location
require('user.package-manager')
require('user.options')
require('user.autocmds')
require('user.commands')
require('user.keymaps')
require('user.lsp')

vim.opt.runtimepath:append({ "~/.config/nvim/plugin/nvim-news" })
