-- file for setting up things that are experiments/temporary
vim.loader.enable()

vim.o.cmdheight = 0

-- single bar on bottom of screen not one on every window
-- you will need some other way of seeing non-current buffer name/status
-- like using 'winbar' as a statusline/statuslinenc replacement
vim.o.laststatus = 3

-- NOTES:
-- 4 window 'types' are used by extui interface:
-- 1. cmdline window, also used for showcmd, showmode, ruler, and echo messages when cmdheight > 0
-- 2. msg window, used for messages when cmdheight == 0
-- 3. pager window, used for `:messages` command, `g<` command, and when command run that would normally
-- dump into nvim's '--More--' window, for example: `:hi`
-- 2. a 'pager' window
require('vim._extui').enable({
  enable = true,
  msg = {
    ---@type 'cmd'|'msg'
    target = 'msg',
    timeout = 4000,
  },
})
