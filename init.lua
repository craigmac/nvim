-- nvim debian stable config (0.10.4)

require('my.globals')
require('my.options')
require('my.autocmds')
require('my.keymaps')
require('my.commands')
require('my.packages')
require('my.lsp')
require('my.colors')

if vim.g.neovide then
 vim.o.guifont = 'Adwaita Mono:h14'
end

-- vi: et tw=120 sw=2 sts=-1
