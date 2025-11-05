--[[
`0` cmdheight will hide the following information:
1. partially entered commands shown by default with `set showcmdloc=last`
   solution:
   * default &stl conditionally shows it if showcmdloc is set to 'statusline'
   * also added to conditional to also show if cmdheight is 0
2. indication of macro recording like `recording @q`
   solutions:
   * conditionally show in &stl somewhere
3. modes shown by `&showmode` like `-- FOO --` where FOO is INSERT|VISUAL|VISUAL BLOCK|REPLACE
   solutions:
   * show at head of &stl using capital letters like 'N|I|V|^V|R'
4. search count like `W [1/4]`
   solutions:
   * conditionally show search count, e.g., `W [1/4]` somewhere in &stl
--]]
vim.o.cmdheight = 0

-- modules
vim.loader.enable()

require 'vim._extui'.enable {
  enable = true,
  msg = {
    target = 'msg',
    timeout = 4000
  }
}

-- `3` value for laststatus requires carefully thought out winbar value
-- vim.o.laststatus = 3

