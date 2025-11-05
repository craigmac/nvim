" https://github.com/justinmk/vim-sneak

" label-mode ensures precise jump the first time, no ; or , required.
" sneak provided operator '[y|d|c|gc]z{object}' is also useful and quicker 'd/' with label-mode on.
let g:sneak#label = 1

" never think about search direction again, ; is forwards and , goes backwards
let g:sneak#absolute_dir = 1

" respect user 'ignorecase and 'smartcase values
let g:sneak#use_ic_scs = 1

" don't use sneak bindings in netrw buffers, keep 's' for 'sort'
let g:sneak#map_netrw = 0

