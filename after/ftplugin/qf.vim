setlocal nonumber
setlocal nolist
setlocal nocursorline
setlocal colorcolumn=

" see `:h global-local` for `=` vs `<` difference
let b:undo_ftplugin ..= ' | setl nu< list< cul< cc='

" adjust the statusline if not disabled by user
" if !get(g:, 'qf_disable_statusline')
"   let b:undo_ftplugin ..= ' | set stl<'

"   " adjust value of stl set in `$VIMRUNTIME/ftplugin/qf.vim`
"   setlocal stl=%t%{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=▼ %l/%L%p% 
" endif
