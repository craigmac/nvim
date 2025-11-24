setlocal nonumber
setlocal nolist

let b:undo_ftplugin ..= ' | setl nu< list<'

hi! link  fugitiveHelpHeader 	    Title
hi! link  fugitiveHeader            Title
hi! link  fugitiveHelpTag           Special

hi! link  fugitiveHash              Constant
hi! link  fugitiveCount             Constant

hi! clear fugitiveSymbolicRef
hi! clear fugitiveHeading
hi! clear fugitiveModifier
hi! clear fugitiveDone
hi! clear fugitiveHunk
hi! clear fugitiveSection
hi! clear fugitivePreposition
hi! clear fugitiveInstruction
hi! clear fugitiveStop

hi! link  fugitiveUntrackedHeading  Title
hi! clear fugitiveUntrackedModifier
hi! clear fugitiveUntrackedSection

hi! link  fugitiveUnstagedHeading   Title
hi! clear fugitiveUnstagedModifier
hi! clear fugitiveUnstagedSection

hi! link  fugitiveStagedHeading     Title
hi! clear fugitiveStagedModifier
hi! clear fugitiveStagedSection

