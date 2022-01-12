" .vim/after/ftplugin/javascript.vim

setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2
setlocal expandtab

let b:undo_ftplugin .= '|setlocal shiftwidth< softtabstop< tabstop< et< fdm<'
