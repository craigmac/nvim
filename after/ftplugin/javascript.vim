setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
setlocal foldmethod=indent
setlocal cursorcolumn | " Easy to follow indent levels with vertical line

let b:undo_ftplugin .= '|setlocal shiftwidth< softtabstop< et< fdm< cursorcolumn<'
