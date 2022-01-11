vim.keymap.set("n", "<Leader>w", "<Cmd>update<CR>")
vim.keymap.set("n", "<Leader>,", "<Cmd>edit ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "]q", "<Cmd>cnext<CR>")
vim.keymap.set("n", "]Q", "<Cmd>clast<CR>")
vim.keymap.set("n", "[q", "<Cmd>cprevious<CR>")
vim.keymap.set("n", "[Q", "<Cmd>cfirst<CR>")
vim.keymap.set("n", "]e", "<Cmd>lnext<CR>")
vim.keymap.set("n", "]E", "<Cmd>llast<CR>")
vim.keymap.set("n", "[e", "<Cmd>lprevious<CR>")
vim.keymap.set("n", "[E", "<Cmd>lfirst<CR>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<M-j>", "<C-w>p<C-e><C-w>p")
vim.keymap.set("n", "<M-k>", "<C-w>p<C-y><C-w>p")
vim.keymap.set("n", "<M-J>", "<C-w>p<C-d><C-w>p")
vim.keymap.set("n", "<M-K>", "<C-w>p<C-u><C-w>p")
vim.keymap.set("n", "<Leader><Leader>", "<Cmd>buffer #<CR>")
vim.keymap.set("n", "<Leader>dd", "<Cmd>bdelete!<CR>")
vim.keymap.set("n", "<F12>", "<Cmd>set wrap!<CR>")
vim.keymap.set("n", "}", "<Cmd>keepjumps normal! }<CR>")
vim.keymap.set("n", "{", "<Cmd>keepjumps normal! {<CR>")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "<F3>", "<Cmd>call utils#ToggleQuickfixList()<CR>")
vim.keymap.set("n", "<F4>", "<Cmd>call utils#ToggleLocationList()<CR>")
vim.keymap.set("n", "<F6>", "<Cmd>15Lexplore<CR>")
vim.keymap.set("n", "<F9>", "<Cmd>set list!<CR>")
vim.keymap.set("n", "<F10>", "<Cmd>set spell!<CR>")

-- TODO: tricky ones to convert
-- vim.keymap.set("v", "J", "<Cmd>m '>+1<CR>gv=gv<CR>")
-- vim.keymap.set("v", "K", "<Cmd>m '<-2<CR>gv=gv<CR>")

vim.keymap.set("n", "gh", "<Cmd>diffget //2<CR>")
vim.keymap.set("n", "gl", "<Cmd>diffget //3<CR>")
vim.keymap.set("c", "<C-n>", function()
	return vim.fn.wildmenumode() == 1 and "<C-n>" or "<Down>"
end, { expr = true })
vim.keymap.set("c", "<C-p>", function()
	return vim.fn.wildmenumode() == 1 and "<C-p>" or "<Up>"
end, { expr = true })

-- keeps marks, settings, and you can still do e.g., <C-o> to jump to it
vim.keymap.set("n", "<Leader>dd", "<Cmd>bdelete!<CR>")
-- REALLY delete the buffer.
vim.keymap.set("n", "<Leader>D", "<Cmd>bwipeout!<CR>")
-- Make THIS the only buffer, mnemonic, alternate to D is Alt-D
vim.keymap.set("n", "<Leader><M-d>", "<Cmd>only!<CR>")

-- TODO: not working this way currently, :lua print(vim.inspect(vim.fn.getcmdtype|getcmdwintype|getcmdline
-- all return empty string, is this because it's running a lua process and no access to getcmdtype?
vim.keymap.set("c", "%%", function()
	return vim.fn.getcmdtype() == ":" and vim.fn.expand("%:h") .. "/" or "%%"
end, { expr = true })

vim.cmd([[
nnoremap <Leader>ft :edit <C-r>=expand('~/.config/nvim/after/ftplugin/'. &ft.'.vim')<CR><CR>
" cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

]])
