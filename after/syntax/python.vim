" File: after/syntax/python.vim
" Author: C.D. MacEachern
" Description: Additional Syntax groups for Python language not defined
" in $VIMRUNTIME/syntax/python.vim
" Last Modified: 2019-04-15 09:49

" From https://docs.python.org/3/reference/lexical_analysis.html#keywords
" Section 'Operators'
syntax match pythonOperators "\v\*"
syntax match pythonOperators "\v\*\*"
syntax match pythonOperators "\v\+"
syntax match pythonOperators "\v-"
syntax match pythonOperators "\v/"
syntax match pythonOperators "\v\<"
syntax match pythonOperators "\v\>"
syntax match pythonOperators "\v\%"
syntax match pythonOperators "\v\="
syntax match pythonOperators "\v\!"
syntax match pythonOperators "\v\|"
syntax match pythonOperators "\v\&"
syntax match pythonOperators "\v\<\<"
syntax match pythonOperators "\v\>\>"
syntax match pythonOperators "\v\=\="
syntax match pythonOperators "\v\!\="
syntax match pythonOperators "\v\<\="
syntax match pythonOperators "\v\>\="

syn match pythonAttribute /\.\h\w*/

highlight! link pythonAttribute Identifier
highlight! link pythonOperators Operator
highlight! link pythonTodo Comment


