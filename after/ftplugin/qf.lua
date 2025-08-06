--set in $VIMRUNTIME/ftplugin/qf.lua:
--setlocal statusline=%t%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''} %=%-15(%l,%c%V%) %P
vim.cmd.packadd('cfilter')
vim.wo[vim.api.nvim_get_current_win()].list = false

-- removes all entries from the same file
vim.cmd([[
nnoremap <buffer> dd :Cfilter! <C-r><C-f><CR>
]])
