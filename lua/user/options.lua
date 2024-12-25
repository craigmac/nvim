vim.g.netrw_banner = 0
vim.g.netrw_list_hide = [[netrw_gitignore#Hide()]]
vim.g.is_posix = 1
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

vim.opt.showmode = false
vim.opt.swapfile = false

vim.opt.exrc = true

-- https://github.com/neovim/neovim/pull/17266
-- vim.opt.laststatus = 3 -- >= 0.7.0

-- FIX: 'fuzzy' in completeopt ignores case and messes up my Tab completion when doing :Ro<Tab>
vim.opt.completeopt = { 'menu', 'menuone', 'popup' }
vim.opt.diffopt:append { 'vertical', 'linematch:60', 'algorithm:patience' }

vim.opt.inccommand = 'split' -- >= 0.8.0

vim.opt.listchars = {
  eol = '¬',
  tab = '󰌒 ',
  trail = '█',
  extends = '»',
  precedes = '«',
}

vim.opt.fillchars:append {
  msgsep = '─', -- char to show above e.g. :messages pane, useful when `hi MsgSeparator` empty
  eob = '-', -- char to show where buffer ends
  fold = ' ', -- char to fill rest of foldline header with
  foldopen = "▶",
  foldclose = "▼",
  diff = " ", -- char used in e.g., diff display to show where text removed
}

-- use option 2 of the 5 ways to use tabs, see `:h 'ts`
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1

-- TODO: still no perfect-to-me solutions available to replace echo area
-- vim.opt.cmdheight = 0 -- >= 0.8.0

-- requires stl value has a %S placeholder in it
vim.opt.showcmdloc = 'statusline'

vim.opt.undofile = true

vim.opt.foldlevelstart = 99
vim.opt.foldtext = ''

-- in milliseconds, default is 4 seconds, but lots of things trigger on this
-- like vim.lsp.buf.document_highlight() so reduce time waiting on it
vim.opt.updatetime = 250

-- ignorecase unless \C used explicitly, or capital letter used
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- default is to follow ignorecase, we want to match case for this
vim.opt.tagcase = 'match'

-- default is on, I toggle it on when needed
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showbreak = '↪ '
-- if wrap is on, scroll by screen line instead of jerky jumps
vim.opt.smoothscroll = true
-- try to restore buffer view to where it was when jump happened
vim.opt.jumpoptions:append { 'view' }

vim.opt.signcolumn = 'yes'           -- better than then constant shifting of the buffer
vim.opt.shortmess = 'aoOstTWAIcCqFS' -- shorten/hide everything possible
vim.opt.pumblend = 15

vim.opt.statusline = "%{%v:lua.require'user.ui'.statusline()%}"
--vim.opt.tabline = "%{%v:lua.require'user.ui'.tabline()%}"

vim.opt.title = true
-- allows using <C-z> in macro/mapping to expand, e.g., `cnoremap ss so $VIM/*.vim<C-z>`
-- because <Tab> (default `:h 'wildchar`) does not work in macros/mappings
vim.opt.wildcharm = vim.fn.char2nr(vim.keycode("<C-z>"))
-- vim.opt.wildmode = { 'full', '
vim.opt.wildignore:append({ '*.swp', '*~', '*.o', '*.obj', '.DS_Store', '*.bak' })
vim.opt.wildoptions:append({ 'fuzzy' })

vim.diagnostic.config({
  float = {
    severity_sort = true,
    border = "rounded",

  },
  severity_sort = true, -- Errors shown first if multiple on a line
})
