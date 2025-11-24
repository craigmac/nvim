" https://github.com/justinmk/vim-sneak

" only run rest of file if related plugin was actually loaded
if !exists('g:loaded_sneak_plugin') | finish | endif

" convenience: when sneak is active, Tab/S-Tab goes to next/previous result
nmap <expr> <Tab> sneak#is_sneaking() ? '<Plug>Sneak_;' : '<Tab>'
nmap <expr> <S-Tab> sneak#is_sneaking() ? '<Plug>Sneak_,' : '<S-Tab>'

" map f/F in all modes to trigger sneak with labels
" trigger on (1) char, forward motion (0), f-like (1), always label (2)
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 2)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 2)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 2)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 2)<CR>
onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 2)<CR>
onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 2)<CR>

" same as above but for t/T in different modes
nnoremap <silent> t :<C-U>call sneak#wrap('',           1, 0, 0, 2)<CR>
nnoremap <silent> T :<C-U>call sneak#wrap('',           1, 1, 0, 2)<CR>
xnoremap <silent> t :<C-U>call sneak#wrap(visualmode(), 1, 0, 0, 2)<CR>
xnoremap <silent> T :<C-U>call sneak#wrap(visualmode(), 1, 1, 0, 2)<CR>
onoremap <silent> t :<C-U>call sneak#wrap(v:operator,   1, 0, 0, 2)<CR>
onoremap <silent> T :<C-U>call sneak#wrap(v:operator,   1, 1, 0, 2)<CR>

" Highlight matches the same way as the / command, unlikely to both have
" search highlights shown while doing a sneak
highlight! link Sneak Search
highlight! link SneakCurrent CurSearch
highlight! link SneakLabel Search
" this one by default adds solid colour block to the second char in the label
" but I just want one block for Label: 'f' in foo not 'fo'o where o is blocked
" out
highlight! clear SneakLabelMask 
" highlighting for the vertical-sneak feature
highlight! SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

