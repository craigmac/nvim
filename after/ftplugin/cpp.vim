" after/ftpluin/cpp.vim -- Local options for C++
" overwriting/adjust defaults in $VIMRUNTIME/ftplugin/c.vim
"
" ctags (Universal ctags) tweak for c++ files:
" $ ctags -R --c++-kinds=+p --fields=+iaS --extras=+q --language-force=C++ .
" Run from top of project dir.

let s:cpo_save = &cpo
set cpo-=C

" CMake with Qt (taken from Qt Creator build steps for MinGW_81_x64 kit
" for Windows. Using path to ninja
setlocal makeprg=
" Clean step is: cmake\ --build\ .\ --target clean

" Single files, compile single file, run single file
nnoremap <buffer> <F6> :!g++ --std=c++17 -Wall -Werror -pedantic %<CR>
nnoremap <buffer> <C-F6> :!%:r<CR>

" Set include pattern
setlocal include=^\\s*#\\s*include
setlocal fdm=syntax

" If ft changed will .cpp buffer open
let b:undo_ftplugin = "setl cpt< inc<"

let &cpo = s:cpo_save
unlet s:cpo_save
