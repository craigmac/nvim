" user overrides for $VIMRUNTIME/ftplugin/nvim-pack.lua

setlocal nonumber
setlocal nolist

let b:undo_ftplugin = exists('b:undo_ftplugin') ? ' | ' : '' .. 'setl nu< list< cc<'

