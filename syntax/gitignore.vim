" Vim syntax file for .gitignore files
" Last Modified: 2020-05-20
"

if exists('b:current_syntax')
  finish
endif

syn keyword gitignoreTodo contained TODO FIXME XXX
" Avoid matching "text#text", used in /etc/disktab and /etc/gettytab
syn match gitignoreComment "^#.*" contains=gitignoreTodo
syn match gitignoreComment "\s#.*"ms=s+1 contains=gitignoreTodo
syn match gitignoreFile "^\(#\)\@!.*\(/\)\@<!$"
syn match gitignoreDirectory "^\(#\)\@!.*\/$"

hi def link gitignoreComment Comment
hi def link gitignoreTodo Todo
hi def link gitignoreDirectory Constant
hi def link gitignoreFile Type

let b:current_syntax = 'gitignore'

setlocal commentstring=#%s
