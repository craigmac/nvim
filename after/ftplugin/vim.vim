setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=80
setlocal foldmethod=marker

setlocal cinwords+=function!
setlocal cinwords+=abort
setlocal cinwords+=augroup

let &l:define = '\C^command\|function'
