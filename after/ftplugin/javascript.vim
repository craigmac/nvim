" .vim/after/ftplugin/javascript.vim
" Author: C.D. MacEachern <craigm@fastmail.com>
" Summary: Modifications to javascript detected filetypes,
" done after $VIMRUNTIME/ftplugin/javascript.vim

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal expandtab
setlocal foldmethod=indent

let b:undo_ftplugin .= '|setlocal shiftwidth< softtabstop< tabstop< et< fdm<'
