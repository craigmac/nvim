-- TODO: use new builtin keymap api
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map("n", "<Leader>w", ":update<CR>", opts)
map("n", "<Leader>,", ":edit ~/.config/nvim/init.lua<CR>", opts)
map("n", "<Leader>gg", "<Cmd>LazyGit<CR>", opts)
map("n", "]q", ":cnext<CR>", opts)
map("n", "]Q", ":clast<CR>", opts)
map("n", "[q", ":cprevious<CR>", opts)
map("n", "[Q", ":cfirst<CR>", opts)
map("n", "]e", ":lnext<CR>", opts)
map("n", "]E", ":llast<CR>", opts)
map("n", "[e", ":lprevious<CR>", opts)
map("n", "[E", ":lfirst<CR>", opts)
map("v", ">", ">gv", opts)
map("v", "<", "<gv", opts)
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("n", "<M-j>", "<C-w>p<C-e><C-w>p", opts)
map("n", "<M-k>", "<C-w>p<C-y><C-w>p", opts)
map("n", "<M-J>", "<C-w>p<C-d><C-w>p", opts)
map("n", "<M-K>", "<C-w>p<C-u><C-w>p", opts)
map("n", "<Leader><Leader>", "<Cmd>buffer #<CR>", opts)
map("n", "<Leader>dd", "<Cmd>bdelete!<CR>", opts)
map("n", "<F12>", "<Cmd>set wrap!<CR>", opts)
map("n", "}", ":keepjumps normal! }<CR>", opts)
map("n", "{", ":keepjumps normal! {<CR>", opts)

vim.cmd([[
" Function keys
nnoremap <F3> :call utils#ToggleQuickfixList()<CR>
nnoremap <F4> :call utils#ToggleLocationList()<CR>
nnoremap <F5> :silent make! % <bar> silent redraw!<CR>
nnoremap <F6> :15Lexplore<CR>
nnoremap <F9> :set list!<CR>
nnoremap <F10> :set spell!<CR>

nnoremap <Leader>ft :edit <C-r>=expand('~/.config/nvim/after/ftplugin/'. &ft.'.vim')<CR><CR>
nnoremap gh :diffget //2<CR>
nnoremap gl :diffget //3<CR>
cnoremap <expr> <C-n> wildmenumode() ? '<C-n>' : '<Down>'
cnoremap <expr> <C-p> wildmenumode() ? '<C-p>' : '<Up>'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]])
