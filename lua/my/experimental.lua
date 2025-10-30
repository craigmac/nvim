-- file for setting up things that are experiments/temporary

vim.loader.enable()
vim.o.cmdheight = 0
vim.o.laststatus = 3

require 'vim._extui'.enable {
  enable = true,
  msg = {
    ---@type 'cmd'|'msg'
    target = 'msg',
    timeout = 4000
  }
}
