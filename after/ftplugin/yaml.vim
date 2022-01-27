" .vim/after/ftplugin YAML filetype settings
" Last Modified: 2020-04-22
" Author: C.D. MacEachern <craigm@fastmail.com>

if exists('current_compiler')
  finish
endif

compiler yamllint-relaxed

setlocal foldmethod=indent

