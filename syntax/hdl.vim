" hdl.vim -- syntax file for *.hdl files (used in nand2tetris.org course)
" Language:    HDL
" Maintainer:  C.D. MacEachern <craigm@fastmail.com
" Credits: original $VIM/syntax/vhdl.vim authors for inspiration and work
" Last Modified: 2019-07-30
"
" 'Mistakes are the portals of discovery.'
" --James Joyce (1882-1941)

" Vim script boilerplate for best practices
if exists("b:current_syntax")
  finish
endif
let s:cpo_save = &cpo
set cpo&vim


syntax clear

" HDL keywords
" Note: HDL is case sensitive
syntax keyword hdlSpecial CHIP IN OUT PARTS BUILTIN CLOCKED

" Commenting
syntax region hdlComment start="/\*" end="\*/"
syntax region hdlComment start="/\*\*" end="\*/"
syntax match hdlComment "\(^\|\s\)//.*"

" Keywords of the language
syntax keyword hdlStatement Nand Not And Or Xor Mux DMux
syntax keyword hdlStatement Not16 And16 Or16 Xor16 Mux16
syntax keyword hdlStatement Or8Way Mux4Way16 Mux8Way16 DMux4Way DMux8Way
syntax keyword hdlStatement HalfAdder FullAdder Add16 ALU Inc16 DFF
syntax keyword hdlStatement Bit Register ARegister DRegister
syntax keyword hdlStatement RAM8 RAM64 RAM512 RAM4K RAM16K
syntax keyword hdlStatement PC ROM32K
syntax keyword hdlStatement Screen Keyboard Memory
syntax keyword hdlConstant true false

" Assignment operators
syntax match hdlOperator "="

" Default highlighting.
highlight! default link hdlSpecial      Special
highlight! default link hdlAttribute    Special
highlight! default link hdlStatement    Statement
highlight! default link hdlCharacter    Character
highlight! default link hdlString       String
highlight! default link hdlTodo         Todo
highlight! default link hdlFixme        Fixme
highlight! default link hdlComment      Comment
highlight! default link hdlNumber       Number
highlight! default link hdlType         Type
highlight! default link hdlOperator     Statement
highlight! default link hdlError        Error
highlight! default link hdlConstant     Constant

let b:current_syntax = "hdl"

" Vim script boilerplate for best practices
let &cpo = s:cpo_save
unlet s:cpo_save
