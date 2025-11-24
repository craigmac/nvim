" https://github.com/justinmk/vim-sneak

" label-mode ensures a precise jump the first time, no undo/redo dance.
" with label-mode on, the `z` operations that sneak provides, like:
" `dz{label}`,
" `yz{label}`,
" `gcz{label}`
" become easier/quicker than their native counterparts, like
" `d/<foo><C-g><C-g>..` due to jumps become more predictable
let g:sneak#label = 1

" pressing f|t resets sneak so that ;|, apply to last f/t motion not last s/S
" when 0 if you pressed `f(` then pressed ; it would not go to next `(` on line
" it would do last sneak again (jump to next match).
"
" downside: you lose ability to do ; and , for next/prev sneak s/S result, but
" there is still `s<CR>` which always repeats last sneak, if you need it
let g:sneak#f_reset = 1
let g:sneak#t_reset = 1

" after a sneak search, s goes to next match, S previous, until you move cursor
let g:sneak#s_next = 1

" never think about search direction again, ; is forwards and , goes backwards
let g:sneak#absolute_dir = 1

" respect user 'ignorecase and 'smartcase values
let g:sneak#use_ic_scs = 1

" don't use sneak bindings in netrw buffers, keep 's' for 'sort'
let g:sneak#map_netrw = 0


