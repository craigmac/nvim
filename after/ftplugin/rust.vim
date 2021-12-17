" after/ftplugin/rust.vim 

" Two commands provided by $VIMRUNTIME/ftplugin/rust.vim:
" :RustRun and :RustExpand
"
let g:rustfmt_autosave = 1 | " default is 0

nnoremap <buffer> <F5> :RustRun<CR>
