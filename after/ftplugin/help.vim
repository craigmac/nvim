" matches: |foo| and 'foo' links, there will be false positives without
" treesitter-level precision doing the heavy work
nnoremap <buffer> <Tab> <Cmd>call search('\(\|[^\|]\+\|\\|''\a\+''\)', 'z')<CR>
nnoremap <buffer> <S-Tab> <Cmd>call search('\(\|[^\|]\+\|\\|''\a\+''\)', 'b')<CR>

nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-t>

