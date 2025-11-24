" only run rest of file if related plugin was actually loaded
if !exists('g:loaded_fugitive') | finish | endif

nnoremap <Leader>gg <Cmd>G<CR>
nnoremap <Leader>gP <Cmd>G push<CR>
nnoremap <Leader>g<Space> :<C-u>G <C-z><S-Tab>
nnoremap <Leader>gc :<C-u>G commit -v <Bar> startinsert<CR>

" open git blame for buffer and use C to resize blame window to just show commit hashes
nmap <Leader>gb :<C-u>G blame <Bar> normal C<CR>

" :Git difftool -y [args] runs `git diff [args]` and for each changed file, open
" a new tabpage with the changed file, and run a :Gdiffsplit! against the appropriate commit

