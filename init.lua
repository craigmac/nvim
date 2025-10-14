-- nvim debian stable config (0.10.4)

local g = vim.g
local opt = vim.o
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

g.mapleader = ' '
g.netrw_banner = 0

-- special characters and display
opt.fillchars = 'eob:~,diff:-,fold: ,foldclose:▶,foldopen:▼,lastline:⋯,msgsep:─'
opt.list = true
opt.listchars = 'eol: ,tab:⇥ ,trail:░,extends:»,precedes:«,nbsp:⍽'
opt.foldcolumn = 'auto'
opt.foldtext = ''

-- no wrap, but if we do enable wrap, use these wrap-related settings
opt.wrap = false
opt.breakindent = true
opt.joinspaces = false
opt.linebreak = true
opt.showbreak = '↳ '
opt.smoothscroll = true

-- searching/matching
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'split'
opt.shortmess = opt.shortmess .. 'cs'
opt.wildcharm = vim.keycode('<C-z>'):byte()
opt.wildignore = '*.o,*.obj,*.dll,*.dylib,.DS_Store,*/.git/*,*/.cache/*,*/.node_modules/*'

-- startup/behaviour
opt.exrc = true
opt.secure = true
opt.diffopt = opt.diffopt .. ',followwrap,algorithm:minimal'
opt.sidescrolloff = 2
opt.scrolloff = 5
opt.undofile = true

autocmd('TextYankPost', { command = "lua vim.highlight.on_yank()" })
autocmd('QuickFixCmdPost', { command = 'botright cwindow 10' })

autocmd('BufReadPost', {
  callback = function()
    local ln = vim.fn.line('\'"')
    local lastln = vim.fn.line('$')
    if ln > 1 and ln <= lastln then vim.cmd.normal({ 'g`"', bang = true }) end
  end
})

map('n', '<Leader>w', '<Cmd>silent update ++p<CR>')
map('n', '<Leader><Space>', '<Cmd>b #<CR>')
map('n', '<Leader>,', ':<C-u>silent tabedit $MYVIMRC <Bar> :tcd %:h<CR>', { silent = true })
map('n', '<Leader>f', ':<C-u>find **/*<C-z>')
map('n', '<Leader>b', ':<C-u>b *<C-z>')

map('n', 'j', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj' end, { expr = true })
map('n', 'k', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk' end, { expr = true })

map('n', '<Leader>vr', ':<C-u>silent tabedit $VIMRUNTIME | tcd $VIMRUNTIME<CR>')
map('n', '<Leader>vp', ':tabe <C-r>=stdpath("data").."/site/pack"<CR> | tcd <C-r>=stdpath("data")<CR><CR>')

map({ 'n', 'x' }, '<Leader>y', '"+y')
map({ 'n', 'x' }, '<Leader>Y', '"+Y')
map({ 'n', 'x' }, '<Leader>p', "\"+pv'[']")
map({ 'n', 'x' }, '<Leader>P', "\"+Pv'[']")

map('n', '<Leader>e', function()
  if not vim.g.loaded_netrw then return ':Ex .<CR>' end
  return vim.w.netrw_rexlocal == 1 and ':Rex<CR>' or ':Ex .<CR>'
end, { expr = true, silent = true })

-- vi: et tw=120 sw=2 sts=-1
