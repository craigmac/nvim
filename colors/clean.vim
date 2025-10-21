" colorscheme inspirations:
" - sweet16
" - alabaster
" - wildcharm
" - quiet
" - neovim default colorscheme

" goals:
" - use the 0-7 colour indexes given by user
" - don't use 8-15 because it's a minefield, especially with base-16
" - user responsible for supplying ANSI palette that works for them
" - related to that, we don't set Normal - we use terminal emulator values
" - instead we use common grey/blacks in the 231-255 index range
" - no termguicolors because we don't know what the ANSI hex values are ahead
"   of time
" - minimal-ish highlighting (keywords of language not highlighted) based upon
"   the ideas of the colorscheme alabaster.
" - comments are kept dim grey. While I agree with 'bright red comments' in
"   theory, in practice it's impractical - we don't always own the code, and
"   staring at tons of bright red docstring blocks all day isn't helpful.
" - instead of using 'darkgrey' (8, we are avoiding 8-15 indexes) use colour from 231-255
" - instead of 'white' (15) use 231 index, use 232 for 'black'
" - g:terminal_ansi_colors is not set, use terminal emulator values
" - no highlighting folded lines

" notes:
" - 'grey' is ANSI 7, do we just set that to fg? might work in both dark/light
"   bg this way?
" - read $VIMRUNTIME/colors/README.txt and setup conditions for dark bg
" - BUG: bg must be set to light in vimrc or else nvim is setting it to dark
"   before it gets here.

let g:colors_name = "clean"

if &t_Co < 256
  echoerr "colorscheme 'sweet16' requires 256 colour minimum"
  unlet g:colors_name
  finish
endif

" reset highlighting to defaults, remove all hl groups added by user and uses
" the current value of &bg to decide which default colours to use
highlight clear

" disable highlighting for Normal and NOT set back to default colours
highlight clear Normal

set notermguicolors

if &background == 'light'
        echomsg 'light bg detected'
        " Folding
        hi! FoldColumn 	ctermbg=NONE	ctermfg=242	cterm=NONE
        hi! link CursorLineFold FoldColumn
        hi! link Folded Normal

        " Signs / Diagnostics
        hi! SignColumn	ctermbg=NONE	ctermfg=242	cterm=NONE
        hi! OkMsg	ctermbg=NONE	ctermfg=darkgreen	cterm=NONE
        hi! WarningMsg	ctermbg=darkmagenta	ctermfg=231	cterm=NONE
        hi! ErrorMsg	ctermbg=darkred	ctermfg=231	cterm=NONE

        " Hidden / Comments / Whitespace / NonText
        hi! Comment	ctermbg=NONE	ctermfg=243	cterm=NONE
        hi! Conceal	ctermfg=231	ctermbg=NONE	cterm=NONE
        hi! ColorColumn	ctermbg=252	ctermfg=NONE	cterm=NONE
        hi! NonText	ctermbg=NONE	ctermfg=248	cterm=NONE
        hi! link EndOfBuffer NonText
        hi! link Whitespace NonText
        hi! link Ignore Conceal

        " Cursor-related
        hi! Cursor	ctermbg=darkgreen	ctermfg=232	cterm=NONE
        hi! lCursor	ctermbg=darkred	ctermfg=231	cterm=NONE
        hi! CursorIM	ctermbg=darkblue	ctermfg=231	cterm=NONE
        hi! CursorLine	ctermbg=255	ctermfg=NONE	cterm=NONE
        hi! CursorLineNr	ctermbg=NONE	ctermfg=darkmagenta	cterm=NONE
        hi! link CursorColumn CursorLine
        hi! link CursorLineSign SignColumn
        hi! TermCursor	ctermbg=NONE	ctermfg=NONE	cterm=reverse

        " diffs
        hi! DiffAdd	ctermbg=darkgreen	ctermfg=231	cterm=NONE
        hi! DiffChange	ctermbg=darkcyan	ctermfg=231	cterm=NONE
        hi! DiffDelete	ctermbg=darkred	ctermfg=231	cterm=NONE
        hi! DiffText	ctermbg=darkyellow	ctermfg=231	cterm=NONE
        hi! link DiffTextAdd DiffAdd
        hi! Added	ctermbg=NONE	ctermfg=darkgreen	cterm=NONE
        hi! Changed	ctermbg=NONE	ctermfg=darkblue	cterm=NONE
        hi! Removed	ctermbg=NONE	ctermfg=darkred	cterm=NONE

        " Questions / Hints / Messages
        hi! link StdoutMsg Normal
        hi! link MsgArea Normal
        hi! ModeMsg 	ctermbg=NONE	ctermfg=darkgreen	cterm=NONE
        hi! MoreMsg 	ctermbg=NONE	ctermfg=darkcyan	cterm=NONE
        hi! Question	ctermbg=NONE	ctermfg=darkblue	cterm=NONE
        hi! SpecialKey	ctermbg=NONE	ctermfg=248	cterm=NONE
        hi! Error	ctermbg=231	ctermfg=darkred	cterm=reverse

        " Separators
        hi! WinSeparator	ctermbg=NONE	ctermfg=242
        hi! link MsgSeparator Normal
        hi! VertSplit	ctermbg=NONE	ctermfg=242	cterm=NONE

        " Search / Match / Selected
        hi! IncSearch	ctermbg=231	ctermfg=darkmagenta	cterm=reverse
        hi! link CurSearch IncSearch
        hi! MatchParen	ctermbg=darkmagenta	ctermfg=231	cterm=NONE
        hi! Search	ctermbg=darkyellow	ctermfg=231	cterm=NONE
        hi! link Substitute Search
        hi! QuickFixLine	ctermbg=darkcyan	ctermfg=231	cterm=NONE
        hi! Visual	ctermbg=darkcyan	ctermfg=231	cterm=NONE
        hi! VisualNOS	ctermbg=darkcyan	ctermfg=232	cterm=NONE
        hi! link SnippetTabstop Visual
        hi! link SnippetTabstopActive SnippetTabstop

        " Line numbers
        hi! LineNr	ctermbg=NONE	ctermfg=242	cterm=NONE
        hi! link LineNrAbove LineNr
        hi! link LineNrBelow LineNr

        " Popups / Completions / Floats
        hi! link NormalFloat Normal
        hi! link FloatBorder NormalFloat
        hi! link FloatTitle Title
        hi! link FloatFooter FloatTitle
        hi! link NormalNC Normal
        hi! WildMenu	ctermbg=darkyellow	ctermfg=231	cterm=NONE
        hi! Pmenu	ctermbg=255	ctermfg=232	cterm=NONE
        hi! PmenuSel	ctermbg=251	ctermfg=232	cterm=NONE
        hi! link PmenuKind Pmenu
        hi! link PmenuKindSel PmenuSel
        hi! link PmenuExtra Pmenu
        hi! link PmenuExtraSel PmenuSel
        hi! link PmenuSbar PmenuSel
        hi! PmenuThumb	ctermbg=NONE	ctermfg=NONE	cterm=reverse
        hi! PmenuMatch	ctermbg=NONE	ctermfg=darkyellow	cterm=NONE
        hi! PmenuMatchSel	ctermbg=NONE	ctermfg=darkmagenta	cterm=NONE
        hi! link ComplMatchIns Normal
        hi! link PreInsert Added
        hi! link ComplHint NonText
        hi! link ComplHintMore MoreMsg

        " spelling / underlining / special highlighting
        " even though &tgc is off, guisp still applies if terminal supports it
        hi! SpellBad	ctermbg=NONE	ctermfg=darkred	cterm=undercurl guisp=darkred
        hi! SpellCap	ctermbg=NONE	ctermfg=darkblue	cterm=undercurl guisp=darkblue
        hi! SpellLocal	ctermbg=NONE	ctermfg=darkmagenta	cterm=undercurl guisp=darkmagenta
        hi! SpellRare	ctermbg=NONE	ctermfg=darkcyan	cterm=undercurl guisp=darkcyan

        " StatusLine / TabLine / WinBar
        hi! StatusLine	ctermbg=242	ctermfg=231	cterm=NONE
        hi! StatusLineNC	ctermbg=250	ctermfg=232	cterm=NONE
        hi! link StatusLineTerm StatusLine
        hi! link StatusLineTermNC StatusLineNC
        hi! TabLineSel	ctermbg=NONE	ctermfg=NONE	cterm=NONE
        hi! link TabLine StatusLineNC
        hi! link TabLineFill StatusLineNC
        hi! link WinBar CursorLine
        hi! link WinBarNC NonText
        hi! Title	ctermbg=NONE	ctermfg=darkmagenta	cterm=NONE

        " Preferred syntax groups, see `:h group-names`
        hi! Constant	ctermbg=NONE	ctermfg=darkmagenta	cterm=NONE
        hi! String	ctermbg=NONE	ctermfg=darkgreen	cterm=NONE
        hi! Identifier	ctermbg=NONE	ctermfg=darkblue	cterm=NONE
        hi! link Function Identifier
        hi! Statement	ctermbg=NONE	ctermfg=NONE	cterm=NONE
        hi! link Operator NonText
        hi! PreProc	ctermbg=NONE	ctermfg=NONE	cterm=NONE
        hi! Type	ctermbg=NONE	ctermfg=NONE	cterm=NONE
        hi! Special	ctermbg=NONE	ctermfg=darkyellow	cterm=NONE
        hi! link Delimiter NonText

        " Misc
        hi! Directory	ctermbg=NONE	ctermfg=darkblue	cterm=NONE
        hi! Todo	ctermbg=NONE	ctermfg=NONE	cterm=reverse
        hi! Underlined	ctermbg=NONE	ctermfg=NONE	cterm=underline
" &bg == 'dark'
else
        echomsg 'dark bg detected'
        " Folding
        hi! FoldColumn 	ctermbg=NONE	ctermfg=242	cterm=NONE
        hi! link CursorLineFold FoldColumn
        hi! link Folded Normal

        " Signs / Diagnostics
        hi! SignColumn	ctermbg=NONE	ctermfg=242	cterm=NONE
        hi! OkMsg	ctermbg=NONE	ctermfg=green	cterm=NONE
        hi! WarningMsg	ctermbg=magenta	ctermfg=231	cterm=NONE
        hi! ErrorMsg	ctermbg=red	ctermfg=231	cterm=NONE

        " Hidden / Comments / Whitespace / NonText
        hi! Comment	ctermbg=NONE	ctermfg=cyan	cterm=NONE
        hi! Conceal	ctermfg=231	ctermbg=NONE	cterm=NONE
        hi! ColorColumn	ctermbg=252	ctermfg=NONE	cterm=NONE
        hi! NonText	ctermbg=NONE	ctermfg=248	cterm=NONE
        hi! link EndOfBuffer NonText
        hi! link Whitespace NonText
        hi! link Ignore Conceal

        " Cursor-related
        hi! Cursor	ctermbg=green	ctermfg=232	cterm=NONE
        hi! lCursor	ctermbg=red	ctermfg=231	cterm=NONE
        hi! CursorIM	ctermbg=blue	ctermfg=231	cterm=NONE
        hi! CursorLine	ctermbg=255	ctermfg=NONE	cterm=NONE
        hi! CursorLineNr	ctermbg=NONE	ctermfg=magenta	cterm=NONE
        hi! link CursorColumn CursorLine
        hi! link CursorLineSign SignColumn
        hi! TermCursor	ctermbg=NONE	ctermfg=NONE	cterm=reverse

        " diffs
        hi! DiffAdd	ctermbg=green	ctermfg=231	cterm=NONE
        hi! DiffChange	ctermbg=cyan	ctermfg=231	cterm=NONE
        hi! DiffDelete	ctermbg=red	ctermfg=231	cterm=NONE
        hi! DiffText	ctermbg=yellow	ctermfg=231	cterm=NONE
        hi! link DiffTextAdd DiffAdd
        hi! Added	ctermbg=NONE	ctermfg=green	cterm=NONE
        hi! Changed	ctermbg=NONE	ctermfg=blue	cterm=NONE
        hi! Removed	ctermbg=NONE	ctermfg=red	cterm=NONE

        " Questions / Hints / Messages
        hi! link StdoutMsg Normal
        hi! link MsgArea Normal
        hi! ModeMsg 	ctermbg=NONE	ctermfg=green	cterm=NONE
        hi! MoreMsg 	ctermbg=NONE	ctermfg=cyan	cterm=NONE
        hi! Question	ctermbg=NONE	ctermfg=blue	cterm=NONE
        hi! SpecialKey	ctermbg=NONE	ctermfg=248	cterm=NONE
        hi! Error	ctermbg=231	ctermfg=red	cterm=reverse

        " Separators
        hi! WinSeparator	ctermbg=NONE	ctermfg=242
        hi! link MsgSeparator Normal
        hi! VertSplit	ctermbg=NONE	ctermfg=242	cterm=NONE

        " Search / Match / Selected
        hi! IncSearch	ctermbg=231	ctermfg=magenta	cterm=reverse
        hi! link CurSearch IncSearch
        hi! MatchParen	ctermbg=magenta	ctermfg=231	cterm=NONE
        hi! Search	ctermbg=yellow	ctermfg=231	cterm=NONE
        hi! link Substitute Search
        hi! QuickFixLine	ctermbg=cyan	ctermfg=231	cterm=NONE
        hi! Visual	ctermbg=cyan	ctermfg=231	cterm=NONE
        hi! VisualNOS	ctermbg=cyan	ctermfg=232	cterm=NONE
        hi! link SnippetTabstop Visual
        hi! link SnippetTabstopActive SnippetTabstop

        " Line numbers
        hi! LineNr	ctermbg=NONE	ctermfg=242	cterm=NONE
        hi! link LineNrAbove LineNr
        hi! link LineNrBelow LineNr

        " Popups / Completions / Floats
        hi! link NormalFloat Normal
        hi! link FloatBorder NormalFloat
        hi! link FloatTitle Title
        hi! link FloatFooter FloatTitle
        hi! link NormalNC Normal
        hi! WildMenu	ctermbg=yellow	ctermfg=231	cterm=NONE
        hi! Pmenu	ctermbg=255	ctermfg=232	cterm=NONE
        hi! PmenuSel	ctermbg=251	ctermfg=232	cterm=NONE
        hi! link PmenuKind Pmenu
        hi! link PmenuKindSel PmenuSel
        hi! link PmenuExtra Pmenu
        hi! link PmenuExtraSel PmenuSel
        hi! link PmenuSbar PmenuSel
        hi! PmenuThumb	ctermbg=NONE	ctermfg=NONE	cterm=reverse
        hi! PmenuMatch	ctermbg=NONE	ctermfg=yellow	cterm=NONE
        hi! PmenuMatchSel	ctermbg=NONE	ctermfg=magenta	cterm=NONE
        hi! link ComplMatchIns Normal
        hi! link PreInsert Added
        hi! link ComplHint NonText
        hi! link ComplHintMore MoreMsg

        " spelling / underlining / special highlighting
        " even though &tgc is off, guisp still applies if terminal supports it
        hi! SpellBad	ctermbg=NONE	ctermfg=red	cterm=undercurl guisp=red
        hi! SpellCap	ctermbg=NONE	ctermfg=blue	cterm=undercurl guisp=blue
        hi! SpellLocal	ctermbg=NONE	ctermfg=magenta	cterm=undercurl guisp=magenta
        hi! SpellRare	ctermbg=NONE	ctermfg=cyan	cterm=undercurl guisp=cyan

        " StatusLine / TabLine / WinBar
        hi! StatusLine	ctermbg=242	ctermfg=231	cterm=NONE
        hi! StatusLineNC	ctermbg=250	ctermfg=232	cterm=NONE
        hi! link StatusLineTerm StatusLine
        hi! link StatusLineTermNC StatusLineNC
        hi! TabLineSel	ctermbg=NONE	ctermfg=NONE	cterm=NONE
        hi! link TabLine StatusLineNC
        hi! link TabLineFill StatusLineNC
        hi! link WinBar CursorLine
        hi! link WinBarNC NonText
        hi! Title	ctermbg=NONE	ctermfg=magenta	cterm=NONE

        " Preferred syntax groups, see `:h group-names`
        hi! Constant	ctermbg=NONE	ctermfg=magenta	cterm=NONE
        hi! String	ctermbg=NONE	ctermfg=green	cterm=NONE
        hi! Identifier	ctermbg=NONE	ctermfg=blue	cterm=NONE
        hi! link Function Identifier
        hi! Statement	ctermbg=NONE	ctermfg=NONE	cterm=NONE
        hi! link Operator NonText
        hi! PreProc	ctermbg=NONE	ctermfg=NONE	cterm=NONE
        hi! Type	ctermbg=NONE	ctermfg=NONE	cterm=NONE
        hi! Special	ctermbg=NONE	ctermfg=yellow	cterm=NONE
        hi! link Delimiter NonText

        " Misc
        hi! Directory	ctermbg=NONE	ctermfg=blue	cterm=NONE
        hi! Todo	ctermbg=NONE	ctermfg=NONE	cterm=reverse
        hi! Underlined	ctermbg=NONE	ctermfg=NONE	cterm=underline
end
" vi: noet vts=20,20
