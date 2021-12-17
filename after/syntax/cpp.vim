" File: after/syntax/cpp.vim
" Author: C.D. MacEachern
" Description: Additional Syntax groups for C++
" Last Modified: 2019-04-15 10:46

syntax match cppOperators "\v\*"
syntax match cppOperators "\v\+"
syntax match cppOperators "\v-"
syntax match cppOperators "\v\/"
syntax match cppOperators "\v\<"
syntax match cppOperators "\v\>"
syntax match cppOperators "\v\%"
syntax match cppOperators "\v\="
syntax match cppOperators "\v\!"
syntax match cppOperators "\v\|\|"
syntax match cppOperators "\v\&\&"
syntax match cppOperators "\v\*\="
syntax match cppOperators "\v\+\="
syntax match cppOperators "\v\-\="
syntax match cppOperators "\v\/\="
syntax match cppOperators "\v\%\="
syntax match cppOperators "\v\=\="
syntax match cppOperators "\v\!\="
syntax match cppOperators "\v\<\="
syntax match cppOperators "\v\>\="
syntax match cppOperators "\v\?"

syntax match cppOperators "\v\<\<"
syntax match cppOperators "\v\>\>"
syntax match cppMisc "\v\:"
syntax match cppScoping "\v\:\:"
syntax match cppSemiColon "\v\;"

syntax region cppComment start=/\v\/\*/ end=/\v\*\//
syntax match cppComment  "\v\/\/.*"

highlight! link cppMisc Comment
highlight! link cppScoping Comment
highlight! link cppSemiColon Comment
highlight! link cppComment Comment


