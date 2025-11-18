setlocal nonumber
setlocal nolist

hi! link  fugitiveHelpHeader 	    Title
hi! link  fugitiveHeader            Label
hi! link  fugitiveHash              Identifier
hi! link  fugitiveSymbolicRef       Function
hi! link  fugitiveHelpTag           Tag
hi! link  fugitiveHelpHeader        fugitiveHeader
hi! link  fugitiveHeading           PreProc
hi! link  fugitiveCount             Number
hi! link  fugitiveInstruction       Type
hi! link  fugitiveStop              Function
hi! link  fugitiveModifier          Type
hi! clear fugitiveDone
hi! clear fugitiveHunk
hi! clear fugitiveSection
hi! clear fugitivePreposition

hi! link  fugitiveUntrackedHeading  PreCondit
hi! link  fugitiveUntrackedModifier StorageClass
hi! clear fugitiveUntrackedSection

hi! link  fugitiveUnstagedHeading   Macro
hi! link  fugitiveUnstagedModifier  Structure
hi! clear fugitiveUnstagedSection

hi! link  fugitiveStagedHeading     Include
hi! link  fugitiveStagedModifier    Typedef
hi! clear fugitiveStagedSection


