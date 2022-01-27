setlocal list
setlocal foldlevel=99
setlocal expandtab
setlocal suffixesadd=.md

" TODO: could be made more robust to support other style Markdown headings
let &l:define = '\v^#+\s*.+$'

nnoremap <buffer> gf :call utils#LiquidInclude()<CR>

" MATCHES:
" 1. {% include {{ page.version }}/snippets/target-platform-before-start.md %}
" 2. ({{ page.version }}/rn/develop/focus-management/#why-we-need-focus)
" 3. (../linux/)
"
" SEARCH PATTERN:
" /{{\s*page.version\s*}}\zs\/[^\.\)]\+\|\.\.\zs\/[^\.\)]\+
setlocal include={{\\s*page.version\\s*}}\\zs\\/[^\\.\\)]\\+\\\|\\.\\.\\zs\\/[^\\.\\)]\\+

compiler liquid

" tagbar plugin support
" Used ':TagbarGetTypeConfig markdown' to dump dict for markdown
" and then just changed 'markdown' to 'liquid' to use the same for ft=liquid
let g:tagbar_type_liquid = {
    \ 'kinds' : [
        \ 'c:chapter',
        \ 's:section',
        \ 'S:subsection',
        \ 't:subsubsection',
        \ 'T:l3subsection',
        \ 'u:l4subsection',
        \ '?:unknown',
    \ ],
\ }
