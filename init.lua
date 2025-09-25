-- nvim debian stable config (0.10.4)

require('my.globals')
require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.packages')
require('my.lsp')

vim.cmd([[hi! Normal guibg=NONE guifg=NONE]])

-- vi: et tw=120 sw=2 sts=-1
