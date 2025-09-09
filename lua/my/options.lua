-- special characters and display
vim.o.cursorline = true
vim.o.fillchars = 'eob: ,diff:-,fold: ,foldclose:▶,foldopen:▼,lastline:⋯,msgsep:─'
vim.o.guifont = 'Adwaita Mono,Inconsolata:h14'
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-TermCursor'
vim.o.listchars = 'eol: ,tab:⇥ ,trail:░,extends:»,precedes:«,nbsp:⍽'
vim.o.list = true
vim.o.number = true
vim.o.winborder = 'single'
vim.o.foldtext = ''

-- no wrap, but if we do enable wrap, use these wrap-related settings
vim.o.wrap = false
vim.o.breakindent = true
vim.o.joinspaces = false
vim.o.linebreak = true
vim.o.showbreak = '↳ '
vim.o.smoothscroll = true

-- searching/matching
vim.o.findfunc = 'v:lua.My.FindFunc'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.o.pumheight = 10
vim.o.shortmess = vim.o.shortmess
    .. table.concat({
        'c', -- no 'match 1 of 2' etc. messages when scrolling through completions
        's', -- no 'search hit BOTTOM...' messages and don't show 'W' for wrapped before [1/3]
        'q', -- no 'recording @q' when recording macro
        -- 'S', -- no [1/5] search count shown
    })
vim.o.wildcharm = vim.keycode('<C-z>'):byte()
-- useful for `:h cmdline-completion`
-- vim.o.wildmode = 'noselect:lastused,full'

-- bars and lines
-- 'stc total-width calculation uses this (default 4) when drawing
vim.numberwidth = 4
vim.o.signcolumn = 'yes'
vim.o.statuscolumn = '%s%=%l%C '
vim.o.foldcolumn = '1'
-- vim.o.statusline = '%!v:lua.require("my.functions").StatusLine()'
-- vim.o.statusline = '%!v:lua.My.StatusLine()'
-- vim.o.tabline = '%!v:lua.My.TabLine()'
-- vim.o.winbar = '%!v:lua.My.Winbar()'

-- editing
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = -1 -- use shiftwidth
vim.o.spelllang = 'en_gb'
vim.o.spelloptions = 'camel,noplainbuffer'
vim.o.spellsuggest = 'fast,5'

-- startup/behaviour
vim.o.exrc = true
vim.o.secure = true
vim.o.diffopt = vim.o.diffopt .. ',followwrap,algorithm:minimal'
vim.o.jumpoptions = vim.o.jumpoptions .. ',view'
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
