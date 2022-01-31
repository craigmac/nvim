setlocal suffixesadd=.lua
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
" turn '.' into '/'
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal foldmethod=indent

" autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
