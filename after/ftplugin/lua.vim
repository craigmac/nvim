setlocal suffixesadd=.lua
setlocal expandtab
setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2
" turn '.' into '/'
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
