" hack.vim -- Syntax file for *.asm Hack machine files
" course on coursera.org
" Language: Hack Assembly Language
" Author: C.D. MacEachern
" Description: Syntax groups for nand2tetris course Hack assembly files
" Last Modified: 2019-08-22

if exists("b:current_syntax")
  finish
endif
let s:cpo_save = &cpo
set cpo&vim

syntax clear

" Hack keywords
syntax keyword hackStatement '@R0' '@R1' '@R2' '@R3' '@R4' '@R5' '@R6' '@R7' '@'
syntax keyword hackStatement '@R8' '@R9' '@R10' '@R11' '@R12' '@R13' '@R14' '@R15'
syntax keyword hackStatement SCREEN KBD SP LCL ARG THIS THAT
syntax keyword hackStatement M D A
" Commenting
syntax region hackComment start="/\*" end="\*/"
syntax region hackComment start="/\*\*" end="\*/"
syntax match hackComment "\(^\|\s\)//.*"

" Assignment operators
syntax match hackOperator "=" "+" "-"

" Default highlighting.
highlight! default link hackSpecial      Special
highlight! default link hackAttribute    Special
highlight! default link hackStatement    Statement
highlight! default link hackCharacter    Character
highlight! default link hackString       String
highlight! default link hackTodo         Todo
highlight! default link hackFixme        Fixme
highlight! default link hackComment      Comment
highlight! default link hackNumber       Number
highlight! default link hackType         Type
highlight! default link hackOperator     Operator
highlight! default link hackError        Error
highlight! default link hackConstant     Constant

let b:current_syntax = "hack"

" Vim script boilerplate for best practices
let &cpo = s:cpo_save
unlet s:cpo_save
