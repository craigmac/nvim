-- global variables
vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

-- special characters and display
vim.o.fillchars = 'eob:⌁,diff: ,fold: ,foldclose:▶,foldopen:▼,lastline:⋯,msgsep:─,trunc:⋯,truncrl:⋯'
-- make `:h Terminal-mode` cursor shape like insert mode to more easily tell from Normal mode
-- especially when using `set noshowmode` (-- TERMINAL --) indicator is hidden
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-TermCursor'
vim.o.listchars = 'eol:↵,tab:⇥ ,trail:░,extends:»,precedes:«,nbsp:⍽'
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
function _G.my.findfunc (cmd_arg, cmd_completions)
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
vim.o.findfunc = 'v:lua._G.my.findfunc'

-- bars and lines
vim.o.signcolumn = 'yes'
vim.o.statusline = table.concat({
  -- current `:pwd` using 'md_folder' in nerdfont
  '󰉋 ',
  -- tail name of tabpage `:pwd`, e.g., 'src' for '/home/foo/src'
  '%{fnamemodify(getcwd(0), ":t")} ',
  -- truncate here as needed to get stl total width <= window width
  '%<',
  -- relative path from :pwd to (f)ilename (or '[No Name]'), max width of 50 characters
  '%.50(%f%) ',
  -- wrap flags with no min-width group, `%( ... %)`, so if no flags are active the group takes up no space
  -- (h)elp buffer, preview (w)indow, buffer (m)odified, buffer (r)eadonly
  '%( [%H%W%M%R]%)',
  -- right-alignment marker, push following items to right of stl
  '%=',
  -- `%{% .. %}` double eval: eval inside first and then eval returned string as stl-format again
  '%{% &showcmdloc == "statusline" ? "%-10.S " : "" %}',
  '%{% exists("b:keymap_name") ? "<"..b:keymap_name.."> " : "" %}',
  -- if ruler option is off (default on), just return empty string, otherwise...
  -- if rulerformat is set use the explicitly set rulerformat string, otherwise...
  -- ruler will show `0:1 All ` in a new empty buffer, a 7 char min width, 14 is default min.
  --
  --
  '%{% &ruler ? ( &rulerformat == "" ? "%7.(%l:%v %P %)" : &rulerformat ) : "" %}',
  '%y',            -- filet(y)pe of the buffer or ''
})

-- vim.o.showtabline = 2
-- function _G.my.tabline ()
--   return table.concat({
--     '%{% tabpagenr() %}',
--     ' %t'
--   })
-- end
-- vim.o.tabline = '%!v:lua._G.my.tabline()'

-- editing
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = -1 -- use shiftwidth

-- startup/behaviour
vim.o.exrc = true
vim.o.secure = true
vim.o.diffopt = vim.o.diffopt .. ',followwrap,algorithm:minimal'
vim.o.jumpoptions = vim.o.jumpoptions .. ',view'
vim.o.scrolloff = 3 -- NOTE: will affect zt, zb, and others
vim.o.sidescrolloff = 5
vim.o.tabclose = 'uselast'
vim.o.undofile = true
-- shorter delay to trigger `:h vim.lsp.buf.document_highlight()`
vim.o.updatetime = 500
vim.o.wildcharm = tonumber(vim.keycode('<C-z>'))
