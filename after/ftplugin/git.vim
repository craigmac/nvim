" buffers that show git patches (like fugitive when you hit <CR> on commit object)
setlocal nolist
setlocal nonumber

" `@@ -0,0 +1,7 @@` lines should stick out more for quick scanning
hi! link diffLine SpecialChar
hi! link diffOldFile Removed
hi! link diffNewFile Added
hi! link gitDate Constant

let b:undo_ftplugin ..= ' | setl list< nu<'

