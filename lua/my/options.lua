-- special characters and display
vim.o.cursorline = true
vim.o.fillchars = 'eob: ,diff:-,fold: ,foldclose:▶,foldopen:▼,lastline:⋯,msgsep:─'
vim.o.guifont = 'Adwaita Mono,Inconsolata:h14'
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-TermCursor'
-- first 3 highlighted by hl-NonText, the rest: hl-WhiteSpace
vim.o.listchars = 'eol: ,extends:»,precedes:«,tab:⇥ ,trail:█,nbsp:⍽'
-- `set list` is useful to spot trailing characters, hard tabs (0x09), and scrolling hints « and ».
-- with eol listchar set to empty, having `list` on is unintrusive and there's no need to toggle it on/off.
vim.o.list = true
vim.o.winborder = 'single'
vim.o.foldtext = ''
vim.o.number = true
-- vim.o.relativenumber = true

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
-- vim.o.tabline = '%!v:lua.My.TabLine()'
-- vim.o.winbar = '%!v:lua.My.Winbar()'
-- default is 20, and so doesn't respect &equalalways
vim.o.helpheight = 0

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
  vim.o.shell = vim.fn.executable('pwsh') == 1 and 'pwsh' or 'powershell'
  vim.o.shellcmdflag = '-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';$PSStyle.OutputRendering=\'plaintext\';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
  vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  vim.o.shellquote = ''
  vim.o.shellxquote = ''
end
