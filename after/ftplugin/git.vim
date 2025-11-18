" buffers that show git patches (like fugitive when you hit <CR> on commit
" object)
setlocal nolist

hi! link diffOldFile Removed
hi! link diffNewFile Added
" `@@ -0,0 +1,7 @@` lines should stick out more to quickly see where
" change chunks are
hi! link diffLine SpecialChar
hi! link gitDate Constant

