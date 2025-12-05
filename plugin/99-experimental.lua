--[[

`set cmdheight=0` implications and workarounds:

* possibly many more redraw updates to `&stl`

  solution(s):
    * hasn't become a problem yet - even 10 year old celeron laptop is fast enough.

* nvim default is to show partially entered commands and visual selections on the right-hand side
  of the cmdline. Hiding cmdheight to 0 hides this information.

  solution(s):
     * nvim updated the builtin `&stl` to show this info if `set showcmdloc=statusline`
     * i've also chosen to show this info in `&stl` when `&ch==0`, regardless of `&showcmdloc` value

* macro recording indicator, `recording @q`, will be hidden if `&cmdheight==0`.
  
  solution(s):
     * show recording indicator in `&stl` somewhere using a conditional

* default nvim shows some modes in the cmdline area, `&cmdheight=0` hides this info.

  solution(s):
    * mostly solved already by nvim changing cursor shapes for insert, visual, and replace modes
    * show it in `&stl`

* default nvim shows a search count like `W [1/4]` in the cmdline. `&cmdheight=0` hides this info.

  solution(s):
   * show search count `&stl` instead
   * show search count in-buffer using extmarks (much more involved solution)


Open related PRs:
* https://github.com/neovim/neovim/pull/30420
* https://github.com/neovim/neovim/issues/24059
* https://github.com/neovim/neovim/issues/28801
* https://github.com/neovim/neovim/issues/20667
--]]
vim.o.cmdheight = 0

-- modules
-- Windows issues again maybe?
-- vim.loader.enable()

-- https://github.com/neovim/neovim/issues/24988
if not vim.g.neovide then
  require 'vim._extui'.enable({
    enable = true,
    msg = {
      target = 'msg',
      timeout = 4000
    }
  })
end

-- `3` value for laststatus requires carefully thought out winbar value
-- vim.o.laststatus = 3

