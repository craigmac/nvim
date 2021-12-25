local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

map('n', '<Leader>w', ':update<CR>', opts)
map('n', '<Leader>,', ':edit ~/.config/nvim/init.lua<CR>', opts)
map('n', ']q', ':cnext<CR>', opts)
map('n', ']Q', ':clast<CR>', opts)
map('n', '[q', ':cprevious<CR>', opts)
map('n', '[Q', ':cfirst<CR>', opts)
map('n', ']l', ':lnext<CR>', opts)
map('n', ']L', ':llast<CR>', opts)
map('n', '[l', ':lprevious<CR>', opts)
map('n', '[L', ':lfirst<CR>', opts)

map('v', '>', '>gv', opts)
map('v', '<', '<gv', opts)

map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)

map('n', '<M-j>', '<C-w>p<C-e><C-w>p', opts)
map('n', '<M-k>', '<C-w>p<C-y><C-w>p', opts)
map('n', '<M-J>', '<C-w>p<C-d><C-w>p', opts)
map('n', '<M-K>', '<C-w>p<C-u><C-w>p', opts)

map('n', '<Leader><Leader>', '<Cmd>buffer #<CR>', opts)
map('n', '<Leader>k', '<Cmd>bdelete!<CR>', opts)

vim.cmd [[
" Function keys
nnoremap <silent><F3> :call utils#ToggleQuickfixList()<CR>
nnoremap <silent><F4> :call utils#ToggleLocationList()<CR>
nnoremap <silent><F5> :silent make! % <bar> silent redraw!<CR>
nnoremap <silent><F6> :15Lexplore<CR>
nnoremap <silent><F9> :set list!<CR>
nnoremap <silent><F10> :set spell!<CR>
nnoremap <Leader>ft :e <C-R>=expand('~/.vim/after/ftplugin/'.&ft.'.vim')<CR><CR>
nnoremap gh :diffget //2<CR>
nnoremap gl :diffget //3<CR>
]]

-- e.g. typing ':help g<C-p>' by default does not search history and simply
--  goes to previous entry, but ':help g<Up>' will search history for previous
-- pattern matching ':help g'. Also Up/Down go in/out of subfolders listings
-- when wildmenu showing - default C-n/p here is to traverse results, equivalent
-- to <Tab>/<S-Tab>. Will need to adjust on Neovim with:
-- cnoremap <expr> <C-p> wildmenumode() ? "<C-P>" : "<Up>"
-- cnoremap <expr> <C-n> wildmenumode() ? "<C-N>" : "<Down>"
-- See: https://github.com/neovim/neovim/issues/16637
vim.cmd [[
cnoremap <expr> <C-n> wildmenumode() ? '<C-n>' : '<Down>'
cnoremap <expr> <C-p> wildmenumode() ? '<C-p>' : '<Up>'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]]
