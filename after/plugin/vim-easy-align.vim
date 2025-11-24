" https://github.com/junegunn/vim-easy-align

" only run rest of file if related plugin was actually loaded
if !exists('g:loaded_easy_align') | finish | endif

" ref:
" * target last equals sign using `-{delimiter}` like `glip-=` 
" * target '|' is very useful for aligning markdown tables

" remove 'center' so <CR> in prompts just toggles between left/right alignments
let g:easy_align_interactive_modes = ['l', 'r']
let g:easy_align_bang_interactive_modes = ['l', 'r']

" default delimiter keys: `:h easy-align-predefined-alignment-rules`, C-x for
" regex entry
vmap gl <Plug>(EasyAlign)
nmap gl <Plug>(EasyAlign)

" version for complex alignments, shows potential changes in real-time
vmap gL <Plug>(LiveEasyAlign)
nmap gL <Plug>(LiveEasyAlign)

