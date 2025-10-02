-- nvim debian stable config (0.10.4)

-- global variables
vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

-- special characters and display
vim.o.fillchars = 'eob:~,diff:-,fold: ,foldclose:▶,foldopen:▼,lastline:⋯,msgsep:─'
vim.o.list = true
vim.o.listchars = 'eol: ,tab:⇥ ,trail:░,extends:»,precedes:«,nbsp:⍽'
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
vim.o.undofile = true

local myaugroup = vim.api.nvim_create_augroup('my.augroup', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = myaugroup,
})

-- goto last edit spot if it exists
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local ln = vim.fn.line('\'"')
    local lastln = vim.fn.line('$')
    if ln > 1 and ln <= lastln then vim.cmd.normal({ 'g`"', bang = true }) end
  end,
  group = myaugroup,
})

vim.keymap.set('n', '<Leader>w', '<Cmd>silent update ++p<CR>')
vim.keymap.set('n', '<Leader><CR>', '<Cmd>source %<CR>')
vim.keymap.set('n', '<Leader><Space>', '<Cmd>b #<CR>')
vim.keymap.set('n', '<Leader>,', ':<C-u>silent tabedit $MYVIMRC <Bar> :tcd %:h<CR>', { silent = true })

-- finding/searching
vim.keymap.set('n', '<Leader>f', ':<C-u>find **/*<C-z>')
vim.keymap.set('n', '<Leader>b', ':<C-u>b *<C-z>')
-- patterns use `:h autocmd-pattern` rules, also see `:h file-pattern`
vim.o.wildignore = '*.o,*.obj,*.dll,*.dylib,.DS_Store'
-- ignore candidate if it includes one of these directories in its full path
vim.o.wildignore = vim.o.wildignore .. '*/.git/*,*/.cache/*,*/.node_modules/*'

vim.keymap.set('n', 'zS', '<Cmd>Inspect<CR>')
vim.keymap.set('n', 'g:', ':<C-u>lua =')
-- visually select the last changed/yanked text
vim.keymap.set('n', 'gV', ':<C-u>normal! `[v`]<CR>')
-- n always goes 'down', N always goes 'up' and never think about this again
vim.keymap.set('n', 'n', ":<C-u>normal! <C-r>='Nn'[v:searchforward]<CR><CR>")
vim.keymap.set('n', 'N', ":<C-u>normal! <C-r>='nN'[v:searchforward]<CR><CR>")
vim.keymap.set('n', 'j', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj' end, { expr = true })
vim.keymap.set('n', 'k', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk' end, { expr = true })
vim.keymap.set('n', '<Leader>vr', ':<C-u>silent tabedit $VIMRUNTIME | tcd $VIMRUNTIME<CR>')
vim.keymap.set('n', '<Leader>vp', ':tabe <C-r>=stdpath("data").."/site/pack"<CR> | tcd <C-r>=stdpath("data")<CR><CR>')

vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+Y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', "\"+pv'[']")
vim.keymap.set({ 'n', 'x' }, '<Leader>P', "\"+Pv'[']")

-- perform last change `:h .` on each line in visual range
vim.keymap.set('x', '.', ':normal! .<CR>')

-- use the history-aware <Up><Down> as default when popup is not visible
vim.keymap.set('c', '<C-p>', function() return vim.fn.pumvisible() >= 1 and '<C-p>' or '<Up>' end, { expr = true })
vim.keymap.set('c', '<C-n>', function() return vim.fn.pumvisible() >= 1 and '<C-n>' or '<Down>' end, { expr = true })

vim.keymap.set('n', '<Leader>e', function()
  if vim.g.loaded_netrw then
    -- avoids error if the window was not previously a netrw window
    if vim.w.netrw_rexlocal == 1 then
      return ':Rex<CR>'
    else
      return ':Ex .<CR>'
    end
  end
  -- :Rex is undefined until netrw fully loaded, use `:Ex` which is always defined
  return ':Ex .<CR>'
end, { expr = true, silent = true })

vim.api.nvim_create_user_command('Cd', 'tcd %:h', {})

-- BUG: workaround for https://github.com/neovim/neovim/issues/33096
vim.api.nvim_create_autocmd('VimEnter', {
  command = 'set termguicolors'
})
-- vi: et tw=120 sw=2 sts=-1
