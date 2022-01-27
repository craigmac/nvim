setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal colorcolumn=80
setlocal wildignore+=*.pyc,*.pyo

" Added in https://github.com/tpict/vim-ftplugin-python/pull/13
" setlocal define=^\\s*\\(def\\\|class\\)

" Better, includes word boundaries with \< and \> to avoid false positives
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>

" from https://youtu.be/Gs1VDYnS-Ac?t=1509
" Setup include search
" :verbose set include? => ^\s*\(from\|import\) set in 
" $VIMRUNTIME/filetype/python.vim
" To see matches what 'include' vale will match in realtime use 
"
" Default value will match
" import argparse
" import wikiquote
"
" But not these:
" import conv.metrics
" from conv import conversion as conv
"
" Default includeexpr shipped with $VIMRUNTIME/ftplugin/python.vim
" substitute(
"   substitute(
"     substitute(v:fname,b:grandparent_match,b:grandparent_sub,''),
"       b:parent_match,b:parent_sub,''),
"         b:child_match,b:child_sub,'g')
"
" Better, tack onto the original
" setlocal includeexpr=^\s*\*(from\|import\) 
" set start of match here with \zs
" setlocal includeexpr+=\zs
" A group of 1+ non-whitespace characters, followed by a whitespace character,
" \s, but as few as possible \{-}. This group occurs 0 or more times, *.
" setlocal includeexpr+=\(\S\+\s\{-}\)*
" previous group appears right before, \ze (:h \ze) end of line or a space and
" 'as'
" setlocal includeexpr+=\ze\($\| as\)
"
" Full unquoted version, for / search
" ^\s*\(from\|import\)\s*\zs\(\S\+\s\{-}\)*\ze\($\| as\)
" becomes when backslashed more here to work
setlocal include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
 
" Case 1:
" import foo.bar
" match: /foo.bar/
"
" Case 2:
" from foo import bar as foo
" match: /foo import bar/
" In python this match could actually be a function and not a module,
" so we want to interpret the match as either:
" /foo import bar/, OR
" foo/bar.py foo.py
" For this one we want to split the string on 'import'
function! PyInclude(fname)
  " Will leave us with an array of either:
  " Case 1 => [foo.bar] 
  " Case 2 => [foo, bar]
  let parts = split(a:fname, ' import ')
  " Case 1 => foo.bar
  " Case 2 => foo (bar is index 1)
  let left_join = parts[0]
  " Case 2: [foo, bar] (two parts to the array)
  if len(parts) > 1
    let right_join = parts[1] " bar
    let joined = join([left_join, right_join], '.') " foo.bar
    " Replace literal dot with a literal /, globally in the string and add .py
    let filepath = substitute(joined, '\.', '/', 'g') . '.py'
    " If we can find it using the new string, then we return because we are done
    let found = glob(filepath, 1)
    if len(found)
      return found
    endif
  endif
  " Case 1: [foo.bar], just replace literal dot with literal /, and add .py
  return substitute(left, '\.', '/', 'g') . '.py'
endfunction
setlocal includeexpr=PyInclude(v:fname)
