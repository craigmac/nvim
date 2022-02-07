setlocal list
setlocal foldlevel=99
setlocal expandtab
setlocal suffixesadd=.md
setlocal iskeyword+=-

let &l:define = '\v^#+\s*.+$'

" TODO: could be made more robust to support other style Markdown headings
let &l:define = '\v^#+\s*.+$'

nnoremap <buffer> gf <cmd>call utils#MarkdownInclude()<CR>

" MATCHES:
" 1. {% include {{ page.version }}/snippets/target-platform-before-start.md %}
" 2. ({{ page.version }}/rn/develop/focus-management/#why-we-need-focus)
" 3. (../linux/)
"
" SEARCH PATTERN:
" /{{\s*page.version\s*}}\zs\/[^\.\)]\+\|\.\.\zs\/[^\.\)]\+
setlocal include={{\\s*page.version\\s*}}\\zs\\/[^\\.\\)]\\+\\\|\\.\\.\\zs\\/[^\\.\\)]\\+

