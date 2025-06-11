-- global variables
vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

-- special characters and display
vim.o.fillchars = 'eob: ,diff: ,fold: ,foldclose:▶,foldopen:▼,msgsep:─'
-- must be single-width characerters, can be utf-8
-- tab options: ⇥ > » → vertical bars work ok for leading tabs, look weird as trailing
vim.o.listchars = 'eol:¬,tab:⇥ ,trail:█,extends:»,precedes: '
vim.o.list = true
vim.o.winborder = 'single'
vim.o.foldtext = ''
vim.o.foldlevelstart = 99
vim.o.showmode = false

-- no wrap, but if we do enable wrap, use these wrap-related settings
vim.o.wrap = false
vim.o.breakindent = true
vim.o.joinspaces = false
vim.o.linebreak = true
vim.o.showbreak = '↳'
vim.o.smoothscroll = true

-- searching/matching
vim.o.completeopt = 'menu,menuone,popup,fuzzy'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.o.pumheight = 10
-- default is 'ltToOCF'
vim.o.shortmess = vim.o.shortmess .. table.concat({
  'c', -- no 'match 1 of 2' etc. messages when scrolling through completions
  's', -- no 'search hit BOTTOM...' messages and don't show 'W' for wrapped before [1/3]
  -- 'q', -- no 'recording @q' when recording macro
  -- 'S', -- no [1/5] search count shown
})
-- fuzzy matching based completion currently not supported for files/dirs - wildcard expansion used instead
vim.o.wildoptions = vim.o.wildoptions .. ',fuzzy'

---Returns a list of filenames as strings using the `rg` binary, so you need to have it installed
---on your system. When used as the provider of filenames for `:help 'findfunc`, the `cmd_completions`
---parameter will be set to `true`.
---
---@param cmd_arg string The command argument to `:find`.
---@param cmd_completions boolean True when function being called to get cmdline matches for `:find` command.
---@return string[]|{} # The list of strings found or an empty list if nothing found/an error occurred.
function _G.RgFiles(cmd_arg, cmd_completions)
  -- not being called from command-line for results for `:h 'findfunc'`
  if not cmd_completions then
    vim.print('RgFiles() cmd_completions was false.')
    -- TODO: what do we want to do here then, just provide all files `rg --files` finds?
    return {}
  end
  -- being called as completion provider for `:find` on command-line
  vim.print('MyFindFunc() cmd_arg: ' .. cmd_arg)
  local pattern = cmd_completions and string.format('%s*', cmd_arg) or cmd_arg

  return { 'fileone', 'filetwo', 'filethree' }
end
vim.o.findfunc = 'v:lua._G.MyFindFunc'

-- bars and lines
vim.o.number = true
vim.o.signcolumn = 'number'
vim.o.statusline = table.concat({
  ' 󰉋 %{fnamemodify(getcwd(0), ":t")}',
  -- '%=',
  ' %f',
  ' %m',
  '%=',
  ' %8.(%l:%c%V%)',
  ' %P',
  ' %y',
})

-- editing
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- startup/behaviour
vim.o.exrc = true
vim.o.secure = true
vim.o.diffopt = vim.o.diffopt .. ',followwrap,algorithm:minimal'
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.undofile = true
-- shorter delay to trigger `:h vim.lsp.buf.document_highlight()`
vim.o.updatetime = 500
vim.o.wildcharm = tonumber(vim.keycode('<C-z>'))
