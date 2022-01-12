vim.cmd([[
nnoremap <Leader>gg :G<CR>
nnoremap <Leader>gP :G push<CR>
nnoremap <Leader>gpp :G pull<CR>
nnoremap <Leader>gdv :Gvdiffsplit<CR>
nnoremap <Leader>gbb :G blame<CR>
nnoremap <Leader>gll :Gclog<CR>
nnoremap <Leader>gcc :G commit -av<CR>
nnoremap <Leader>g/ :Ggrep! --quiet<Space>
]])
