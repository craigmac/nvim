# Vim notes

Just stuff I forget/need to reference that I often forget and/or want
out of my brain!

## Scripting

## Gotchas and Best Practices

* `:help eval.txt` is the bible and final say.
* I added `:API` command to bring up `:h function-list`
* always use mapping variants to don't look for mappings in the 'rhs'
(right hand side) of the mapping: use `:noremap`, `:nnoremap`, `:inoremap`
, etc. This is almost always what you want, unless you want the rhs
of the mapping to call it's possible mappings too.
* special characters in a mapping: use <Bar> for '|' because map command
can be followed by another command and the | character separates two
commands. To include one use the <Bar> symbolic, e.g.,
`:noremap <F8> :write <Bar> !ls<CR>`. For literal spaces use <Space>, e.g.,
`:noremap <Space> W`
* You cannot put comment after a mapping because it will consider it
part of the mapping. End the map with '|' first the use a comment, e.g.,
`:map <Space> W| " use spacebar to move forward a Word.
* <script> : make mapping local to the script run in.
* <buffer> : make mapping local to that buffer.
* <unique> : make mapping fail if it exists already. Default is to overwrite.
* <Nop> : No operation. Do nothing when mapped to this.
* User-defined commands MUST begin with a capital letter. e.g.,
`:command DeleteFirstLine 1delete`. Can't use 'X', 'Next', and 'Print'.
Also no underscores. Digits ok, but discouraged.
* Always add '!' to `:command` and `:function` definitions to allow resourcing
and overwriting existing function of same name.
* Command arguments:
  * e.g., `:command! -nargs=0 DeleteFirst 1delete` (0 default nargs opt. here)
  * -nargs=0 No args
  * -nargs=1 One argument
  * -nargs=* Any numbers of args, including 0
  * -nargs=? Either 0 or 1 argument only
  * -nargs=+ At least 1 argument
* Argument usage:
  * `:command -nargs=+ Say :echo "<args>"` and do `:Say Hello World`
  * with above adding quotes will error, e.g., `:Say Hello "world"`
  * to fix that, use `<q-args>` which means 'quote arguments', e.g.,
  `:command! -nargs=+ Say :echo <q-args>` NOTE NO QUOTES AROUND q-args
  * <f-args> : keyword contains same info as <args> but put in a format
  suitable for using as function call args, e.g.,
  `:command! -nargs=\* DoIt :call AFunction(<f-args>)`
  * `:DoIt a b c` executes like this: `:call AFunction("a", "b", "c")`
* Line Ranges as arguments:
  * -range Range allowed, default is current line
  * -range=% Range allowed, whole file by default
  * -range={count} Range allowed; last number in it is used as a single
  number whose default is {count}.
  * `:command -range=% SaveIt :<line1>,<line2>write! savefilename`
* Other command options:
  * -count={number} command can take count, number as default. Can be used
  through the <count> keyword in the body of the function.
  * -bang You can use a '!' character. Using <bang> will result in '!'
  * -register You can specify a register. Default is unnamed.
  * -complete={type} Type of completions you can use for this command.
  See `:command-completion` for list of values you can use.
  * -bar The command can be followed by '|' and another command or
  a comment
  * -buffer The command is only available for current buffer.
* <lt> keyword that stands for the character '<'. Use this to escape
any special meaning of the <..> items.
* Form of autocommands. [foo] means optional:
  * `:autocmd [group] {EventName} {file\_pattern} [nested] {command}`
* Autocommand examples:
```vim
:autocmd BufWritePre * call DateInsert()
:autocmd BufReadPost,BufRead *.gsm set filetype=asm
:autocmd BufNewFile *.[ch] 0read ~/.vim/skeletons/skel.c
:autocmd BufNewFile *.cpp,*.h set filetype=cpp
" Remove all from this group
:autocmd! FileWritePre *
" List them
:autocmd [Group]
" Groups, called auto groups
:augroup init
  :autocmd!
  :autocmd BufReadPost *.c,*.h set sw=4 sts=4
	:autocmd BufReadPost *.cpp   :set sw=3 sts=3
:augroup END
" 'nested' will allow the autocmd to trigger other ones, usually won't
:autocmd FileChangedShell * nested edit
" You can manually execute an autocmd by pretending one occured
:autocmd BufReadPost *.new execute "doautocmd BufReadPost "
  \ . expand("<afile>")
" will result in executing this command when buffer *.new read:
:doautocmd BufReadPost tryout.c
:autocmd BufReadPost *.chg execute "normal! 0New entry:\<Esc>" | 1read !date

```


## Comparison Operators (==, =?, ==#, etc.)

* always use `==#` to match case and e.g., `>=?` to ignore case.
* see `:h expr4` for details on comparing expressions.

## Functions

* always add `abort` keyword, e.g., `function! foo() abort `
* always use `function!` to allow overriding an existing function of
same name


# Vimscript vs. Vim 9 Reference

## Variables



# Whitespace and Tab Settings

Explanations of and defaults for these settings:

* tabstop
* shiftwidth
* shiftround
* softtabstop
* expandtab
* autoindent

Which are all related to whitespace/tab settings.

```vim
" Whitespace/Tab Settings
" Number of spaces <Tab> counts for. Whether 1 tab byte 0x09 will be replaced
" set tabstop=8
" Governs how much to indent (e.g., >> command)
" Whether it uses spaces or tab character is up to a few settings:
"   * if 'noexpandtab': tries to use tab bytes (\x09) alone. It will use
"   spaces as needed if the result of tabstop / shiftwidth is not 0.
"   * if 'expandtab': only use space bytes.
" Unless you want mixed tab and space bytes (THE HORROR.) if you set
" tabstop and shiftwidth to different values that are non equally divisible,
" use 'expandtab'.
" set shiftwidth=8
" Rounds indenting actions to a multiple of 'shiftwidth' if this is on.
" set noshiftround
" Number of spaces that tab byte \x09 counts for when doing edits like
" when pressing <Tab> or <BS>. It uses a mix of space \x020 and tab
" \x09 bytes. Useful to keep tabstop at 8 while being able to add tabs
" and delete like it is set to softtabstop (insert/remove that many
" whitespaces, made up of space and tab characters).
"  * if 'noexpandtab': number of \x020 (space) bytes are minimized by
"  inserting as many \x09 (tab) bytes as possible.
" set softtabstop=0
" Don't use space bytes \x020 to make up tab \x09 bytes, use real tabs.
" Technically small filesizes with tab characters, but with minification
" on most web/code now being popular, this doesn't matter as much.
" set noexpandtab
" Do not copy indent from current line when starting new line: <CR>,o,O
" set noautoindent
```

# Script Examples from usr41.txt

" global variable "i"
let i = 1
while i < 5
  echo "count is" i
  let i += 1
endwhile

" script variables
let s:count = 1
while s:count < 5
  echo s:count
  let s:count += 1
endwhile

" buffer variable
let b:foo = 'literal string no interpolation'

" window-local variable
let w:foo = "double quotes for interpreting special characters"

" pre-defined Vim variables under v: prefix, g: prefix not needed but common
" for global variables
let g:errors = v:errors

for i in range(1, 4)
  echo "count is " i
endfor

echo 0x7f 036 1.0 " => 127 30
echo 10 + 1.5 " => 11.5

unlet s:count
unlet! s:will_not_error_with_bang

" if s:call_count is not quoted it will be the variable itself, not the value
" NO
" if !exists(s:call_count)
" YES
if !exists("s:call_count")
  let s:call_count = 0
endif
let s:call_count += 1
" when a script finishes, the s: variables are kept around, not freed
" so they can be reused.
echo "called " s:call_count "times"

" Conversions and Coercions
if "true"
  echo "This will never print because above is a string and" .
    \ "vim tries to convert a string to a number, and because it" .
    \ " does not starting with a number, returns 0, which is false."
elseif v:true
  echo "This is the real 'true' boolean."
else
  echo "Will never print."
endif

" For all double quote related see: :h expr-quote
let g:double_quote_strings = "Here is a tab: \t and here is a " .
  \ " line break: \n another: \r we can use any '<name>' inside a " .
  \ "double quoted string by putting a backslash before left tag opening"

" EXPRESSIONS. Heart of vim script. Full definition at :h expression-syntax.
echo $ENVIRONMENT_VARIABLE
echo &complete| " echoes value of 'complete' option (e.g. 'set complete')
echo @r| " echoes anything stored in register r

" NOTICE: no extra space before closing double quote!
echo "The Value of 'tabstop' is" &ts
echo "Your home directory is at" $HOME

" Save an option in a local var
let s:saved_ic = &ic
set noic
/The Start/,$delete
" How you change value of 'set foo' (any option) when you need result
" of right hand side expression, here it evaluates to original value of ic.
let &ic = s:saved_ic

" Tertiary
let i = 4
echo i > 5 ? "i is big" : "i is small"

" Checking vim option value conditionally
" ==# means match exactly the case, ==? means case insensitive
" =~, =~#, =~? are regex match conditionals with optional case sensitivities
if &term ==# 'xterm'
  echo 'yep'
endif

" Test a line in command line
:if 5 == 5 | echo "yes" | endif
:if 0 == "false" | echo "yes" | endif

