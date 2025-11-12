-- settings: variables and options

-- global variables
vim.g.mapleader                = ' '
vim.g.netrw_banner             = 0
vim.g.netrw_hide               = 0
-- make v and o do splitright and splitbelow
vim.g.netrw_altv               = vim.o.splitright
vim.g.netrw_alto               = vim.o.splitbelow
-- turn off highlighting strings in vim ft comments, if not using treesitter
vim.g.vimsyn_comment_strings   = false

-- stops these $VIMRUNTIME/plugin files from loading completely (tiny impact on startup)
vim.g.loaded_gzip              = 'any string should fail exists() test'
vim.g.loaded_zipPlugin         = 'keep your bible quotes to yourself'
vim.g.loaded_remote_plugins    = 'never use this'
vim.g.loaded_tarPlugin         = 'nope I never browse .tar files'
vim.g.loaded_tutor_mode_plugin = 'no more :Tutor'
-- I'm giving up on trying to get a Canadian English .spl dictionary file to build and work
-- (cf. https://github.com/vim/vim/issues/9042 and other open issues summarize the poor builtin spelling support)
-- instead use one of the many external maintained spelling LSPs like Harper/Vale/Codebook
vim.g.loaded_spellfile_plugin  = true

-- special characters and display
vim.o.cursorline               = true
vim.opt.fillchars              = {
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
vim.o.guifont                  = 'Adwaita Mono,Inconsolata:h14'
vim.o.guicursor                = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-TermCursor'
vim.opt.listchars              = {
  -- these use hl-NonText
  eol      = '¬', -- upgrade from `$`
  extends  = ' ', -- no modern editor uses this, not needed
  precedes = ' ', -- no modern editor uses this, not needed
  -- these use hl-WhiteSpace, which is by default linked to NonText
  tab      = '⇥ ', -- upgrade from `> `
  trail    = '█', -- trailing space at eol. full block to make it more obvious
  nbsp     = '⍽', -- for a couple of non-breaking-space unicode characters
  space    = '·' -- common in modern editors to use middle dot
}
-- default &stl conditionally shows incomplete/selection counts if this value is set
vim.o.showcmdloc               = 'statusline'
vim.o.winborder                = 'single'
vim.o.foldtext                 = ''
vim.o.number                   = true


-- wrapping
-- no wrap, but if we do enable wrap, use these wrap-related settings
vim.o.wrap = false
vim.o.breakindent = true
vim.o.breakindentopt = 'sbr'
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
  'S', -- no [1/5] search count shown
})
vim.o.wildcharm = vim.keycode('<C-z>'):byte()

-- bars/lines/windows

-- see docs for how width is determined (it's complicated)
vim.o.statuscolumn = table.concat({
  '%@SignCb@',
  '%s', -- (s)ign like git-related or diagnostics
  '%X', -- end click area for callback
  -- '%@LineCb@',
  '%@call v:lua.print"hey"@',
  '%l',  -- (l)ine number for currently drawn line, consults 'numberwidth' for minimum width
  '%X',  -- end click area for callback
  '%=',  -- divider, push following content to far-right
  '%C ', -- fold (C)olumn for currently drawn line
})
-- 'auto' spares wasted cols when no folds are present
vim.o.foldcolumn = 'auto:2'
-- always start with nothing folded
vim.o.foldlevelstart = 99
-- always save 1 column space for signs - default 'auto' pops column in/out as needed if we are really tight on space
vim.o.signcolumn = 'yes:1'
-- `%!` here means use string as an expression: eval it, and use the result as the option value
vim.o.statusline = "%!v:lua.require'my.functions'.StatusLine()"

-- default is 20, and so doesn't respect &equalalways
vim.o.helpheight = 0
-- tried the 'native' defaults for years, i still prefer this way like modern editors
vim.o.splitright = true
vim.o.splitbelow = true

-- completion/finding
vim.o.autocomplete = true
vim.o.complete = 'o^10,.^10,w^5,b^5'
vim.o.completeopt = 'menuone,popup,fuzzy,noselect'
vim.o.completefuzzycollect = 'keyword,files,whole_line'
-- special `:h v:lua` required here to pass lua callback name, see `:h option-value-function`
vim.o.findfunc = "v:lua.require'my.functions'.FindFunc"
vim.o.wildmode = 'noselect:lastused,full'
vim.o.wildoptions = 'exacttext,fuzzy,pum,tagfile'

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

-- remove default popup menu entries
vim.cmd([[
silent! aunmenu PopUp.How-to\ disable\ mouse
silent! aunmenu PopUp.-2-
]])

-- Windows 10+ settings
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
