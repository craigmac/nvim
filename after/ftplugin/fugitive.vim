setlocal nonumber
setlocal nolist

" in roughly the order of appearance top to bottom in the `:G` status buffer
hi! link  fugitiveHeader            Title
hi! link  fugitiveHelpHeader 	    Title
hi! link  fugitiveUnstagedHeading   fugitiveHeader
hi! link  fugitiveStagedHeading     fugitiveHeader
hi! link  fugitiveUntrackedHeading  fugitiveHeader

hi! link  fugitiveHash              Constant
hi! link  fugitiveCount             Constant

hi! link fugitiveSymbolicRef        Underlined
hi! link  fugitiveHelpTag           Underlined

hi! link fugitiveHeading            Title
hi! link fugitiveCount              Constant
hi! link fugitiveModifier           Special

hi! link  diffLine                  Special
hi! link  diffAdded                 Added
hi! link  diffRemoved               Removed
hi! link  diffChanged               Changed

"hi! clear fugitiveDone
"hi! clear fugitivePreposition
"hi! clear fugitiveInstruction
"hi! clear fugitiveStop

if exists("b:did_ftplugin")
  let b:undo_ftplugin ..= ' | setl nu< list<'
endif

