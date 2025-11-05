-- settings: variables and options

-- global variables 
vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0
-- make v and o do splitright and splitbelow
vim.g.netrw_altv = vim.o.splitright
vim.g.netrw_alto = vim.o.splitbelow
-- turn off highlighting strings in vim ft comments, if not using treesitter
vim.g.vimsyn_comment_strings  = false

-- stops these $VIMRUNTIME/plugin files from loading completely (tiny impact on startup)
vim.g.loaded_gzip = 'any string should fail exists() test'
vim.g.loaded_zipPlugin = 'keep your bible quotes to yourself'
vim.g.loaded_remote_plugins = 'never use this'
vim.g.loaded_tarPlugin = 'nope I never browse .tar files'
vim.g.loaded_tutor_mode_plugin = 'no more :Tutor'

-- special characters and display (ref. `:digraphs!`)
vim.o.cursorline = true
vim.opt.fillchars = {
  eob       = ' ', -- with `set nu` this isn't needed
  diff      = ' ', -- default is `-`. deleted lines of the 'diff' option. rely on hl-DiffDelete for that.
  fold      = ' ', -- remove the 'foldtext' filling symbol, leave the folded line as-is
  foldclose = '▶', -- default is `+`
  foldinner = ' ', -- default would show a number like 2 representing foldlevel when foldcolumn too narrow. ugly.
  foldopen  = '▼', -- default is `-`
  foldsep   = ' ', -- default is `│` or `|`, i'd rather none like zed/code/modern editors
  lastline  = ' ', -- archaic, confusing, and pointless - especially with default `@@@`
  msgsep    = '─', -- default is empty. I link hl-MsgSeparator to Normal so a symbol is needed
  trunc     = ' ', -- default `>`. no need.
  truncrl   = ' ', -- ditto, but `<`
}
vim.o.guifont = 'Adwaita Mono,Inconsolata:h14'
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-TermCursor'
vim.opt.listchars = {
  -- these use hl-NonText
  eol      = '¬',  -- upgrade from `$`
  extends  = ' ',  -- no modern editor uses this, not needed
  precedes = ' ',  -- no modern editor uses this, not needed
  -- these use hl-WhiteSpace, which is by default linked to NonText
  tab      = '⇥ ', -- upgrade from `> `
  trail    = '█',  -- trailing space at eol. full block to make it more obvious
  nbsp     = '⍽',  -- for a couple of non-breaking-space unicode characters
  space    = '·'   -- common in modern editors to use middle dot
}
-- turn on but hide them until cursor on same line or visually selected by tweaking hl-WhiteSpace and hl-NonText
vim.o.list = true
-- default &stl conditionally shows incomplete/selection counts if this value is set
vim.o.showcmdloc = 'statusline'
vim.o.winborder = 'single'
vim.o.foldtext = ''
vim.o.number = true

-- no wrap, but if we do enable wrap, use these wrap-related settings
vim.o.wrap = false
vim.o.breakindent = true
vim.o.joinspaces = false
vim.o.linebreak = true
vim.o.showbreak = '↳ '
vim.o.smoothscroll = true

-- searching/matching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.findfunc = "v:lua.require'my.functions'.FindFunc"
vim.o.inccommand = 'split'
vim.o.pumheight = 10
vim.o.shortmess = vim.o.shortmess .. table.concat({
  'c', -- no 'match 1 of 2' etc. messages when scrolling through completions
  's', -- no 'search hit BOTTOM...' messages and don't show 'W' for wrapped before [1/3]
  'q', -- no 'recording @q' when recording macro
  -- 'S', -- no [1/5] search count shown
})
vim.o.wildcharm = vim.keycode('<C-z>'):byte()

-- bars/lines/windows
vim.o.statuscolumn = '%s%l%=%C '
-- auto spares wasting cols when no folds are present
vim.o.foldcolumn = 'auto:2'
-- always save 1 column space for signs - default 'auto' pops column in/out as needed if we are really tight on space
vim.o.signcolumn = 'yes:1'
vim.o.statusline = "%!v:lua.require'my.functions'.StatusLine()"

-- default is 20, and so doesn't respect &equalalways
vim.o.helpheight = 0 
-- tried the 'native' defaults for years, i still prefer this way like modern editors
vim.o.splitright = true
vim.o.splitbelow = true

-- editing
vim.o.spelllang = 'en_gb'
vim.o.spelloptions = 'camel,noplainbuffer'
vim.o.spellsuggest = 'fast,5'

-- startup/behaviour
vim.o.exrc = true
vim.o.secure = true
vim.o.diffopt = vim.o.diffopt .. ',followwrap,algorithm:minimal'
vim.o.jumpoptions = vim.o.jumpoptions .. ',view'
-- + fewer instances of stopping coding to do something like <C-o>zz to recenter codevia zz and be able to see
-- + function definition/docs more if did e.g., zt on function definition linezt/zl will not be true top/lower
-- - zt/zb will not place current line to true top/bottom, it will always be &scrolloff lines away
-- ~ some behaviours like jumping to a character 4 lines from the bottom will scroll screen
vim.o.scrolloff = 5
vim.o.sidescrolloff = 2
vim.o.tabclose = 'uselast'
vim.o.undofile = true
-- shorter delay to trigger `:h vim.lsp.buf.document_highlight()`
vim.o.updatetime = 500

-- remove popup menu entry, guarded to prevent error on re-sourcing this file
if not vim.g.popup_menu_fixed then
  vim.cmd([[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-2-
  ]])
  vim.g.popup_menu_fixed = true
end

if vim.fn.has('win64') == 1 then
  vim.o.shell = vim.fn.executable('pwsh') == 1 and 'pwsh -NoLogo' or 'powershell'
  vim.o.shellcmdflag = '-NonInteractive -ExecutionPolicy RemoteSigned -Command'
  vim.o.shellslash = true
  vim.o.shellquote = ''
  vim.o.shellxquote = ''
  -- vim.o.shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.o.shellpipe = '>%s 2>&1'
  -- vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellredir = '>%s 2>&1'
end
