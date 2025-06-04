vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

-- special characters and display
vim.o.fillchars = 'eob: ,diff: ,fold: ,foldclose:▶,foldopen:▼,msgsep:─'
-- must be single-width characerters, can be utf-8
-- tab options: ⇥ > » → vertical bars work ok for leading tabs, look weird as trailing
vim.o.listchars = 'eol:¬,tab:⇥ ,trail:█,extends:»,precedes: '
vim.o.list = true
vim.o.winborder = 'rounded'
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

-- bars and lines
vim.o.number = true
vim.o.signcolumn = 'number'
vim.o.statusline = table.concat({
  ' 󰉋 %{fnamemodify(getcwd(0), ":t")}',
  -- '%=',
  ' %.20f',
  ' %m',
  '%=',
  ' %8.(%l:%c%V%)',
  ' %P',
  ' %y',
})

-- startup/behaviour
vim.o.exrc = true
vim.o.secure = true
vim.o.diffopt = vim.o.diffopt .. ',followwrap,algorithm:minimal'
-- using option 1 in `:help 'tabstop`
vim.o.softtabstop = -1
vim.o.shiftwidth = 2
vim.o.scrolloff = 5
vim.o.sidescrolloff = 10
vim.o.undofile = true
-- shorter delay to trigger `:h vim.lsp.buf.document_highlight()`
vim.o.updatetime = 500
vim.o.wildcharm = tonumber(vim.keycode('<C-z>'))
