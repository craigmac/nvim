-- special characters and display
vim.o.fillchars = 'eob:-,diff:-,fold: ,foldclose:▶,foldopen:▼,lastline:⋯,msgsep:─'
vim.o.listchars = 'eol:¬,tab:⇥ ,trail:░,extends:»,precedes:«,nbsp:⍽'
vim.o.list = true
vim.o.foldtext = ''
vim.o.foldlevelstart = 99
vim.o.showmode = false

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
-- vim.o.statusline = '%!v:lua.My.StatusLine()'
-- vim.o.tabline = '%!v:lua.My.TabLine()'
-- vim.o.winbar = '%!v:lua.My.Winbar()'

-- editing
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = -1
vim.o.spelllang = 'gb'
vim.o.spelloptions = 'camel,noplainbuffer'
vim.o.spellsuggest = 'fast,5'

-- startup/behaviour
vim.o.exrc = true
vim.o.secure = true
vim.o.diffopt = vim.o.diffopt .. ',followwrap,algorithm:minimal'
vim.o.jumpoptions = vim.o.jumpoptions .. ',view'
vim.o.sidescrolloff = 2
vim.o.undofile = true
-- shorter delay to trigger `:h vim.lsp.buf.document_highlight()`
vim.o.updatetime = 500

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
