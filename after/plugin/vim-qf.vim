" only run rest of file if related plugin was actually loaded
if !exists('g:loaded_qf') | finish | endif

" open current item in (s)plit, (v)ertical, (t)ab, (o)pen and come back,
" (O)pen and close loc/qf window, (p)review
let g:qf_mapping_ack_style = 1
" turn off 'number in qf filetype
let g:qf_number = 0
" otherwise 'p' doesn't work to preview an entry after doing :[lh]elpgrep
" because we need full path to $VIMRUNTIME/doc/ prepended, but only get e.g.,
" `pedit +33 if_python.txt` instead, which just previews an new empty buffer
" named 'if_python.txt'
let g:qf_shorten_path = 0

nnoremap <Leader>q <Plug>(qf_qf_toggle)
nnoremap <Leader>l <Plug>(qf_log_toggle)

augroup my.augroup.quickfix | au!
  autocmd FileType qf nnoremap <buffer> dd :.Reject<CR>
  autocmd FileType qf xnoremap <buffer> d :Reject<CR>
augroup END

