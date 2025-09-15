-- special characters and display
vim.o.fillchars = 'eob:~,diff:-,fold: ,foldclose:▶,foldopen:▼,lastline:⋯,msgsep:─'
vim.o.listchars = 'eol:¶,tab:⇥ ,trail:░,extends:»,precedes:«,nbsp:⍽'
vim.o.list = true
vim.o.foldcolumn = 'auto'
vim.o.foldtext = ''
vim.o.foldlevelstart = 99

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
vim.o.inccommand = 'split'
vim.o.pumheight = 10
vim.o.shortmess = vim.o.shortmess .. 'cs'
vim.o.wildcharm = vim.keycode('<C-z>'):byte()

-- bars and lines
vim.o.signcolumn = 'yes'
-- vim.o.statusline = '%!v:lua.require("my.functions").StatusLine()'
-- vim.o.tabline = '%!v:lua.require("my.functions").TabLine()'
-- vim.o.winbar = '%!v:lua.require("my.functions").Winbar()'

-- editing - use option 1 of 5 (!!) ways to use `:h 'tabstop`
vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.spelloptions = 'camel,noplainbuffer'
vim.o.spellsuggest = 'fast,5'

-- startup/behaviour
vim.o.exrc = true
vim.o.secure = true
vim.o.diffopt = vim.o.diffopt .. ',followwrap,algorithm:minimal'
vim.o.jumpoptions = vim.o.jumpoptions .. ',view'
vim.o.sidescrolloff = 2
vim.o.title = true
vim.o.undofile = true

vim.diagnostic.config({
  float = {
    border = 'single',
    header = 'Diagnostics',
    severity_sort = true,
    source = true,
  },
  severity_sort = true,
  virtual_text = false,
})
