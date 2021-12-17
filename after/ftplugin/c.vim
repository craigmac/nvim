" after/ftplugin/c.vim
" My .c local buffer settings
" Last Modified: 2019-09-20

compiler gcc

set makeprg=gcc\ -o\ %:p:r\ %:p\ -std=c89
" Run executable named after current buffer
noremap <buffer><F6> :exe "!" . expand('%:p:r')<CR>
