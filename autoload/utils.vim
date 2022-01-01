" vim: set foldmethod=indent foldlevel=0 textwidth=100 filetype=vim :
" Author: C.D. MacEachern <craigm@fastmail.com> vim 7.4+ config file.
" Last Modified: 2020-09-17
" local.vim -- utility functions that I use

function! utils#SwitchSourceHeader() abort
  " Switch between cpp/.h files
  if &ft ==# 'cpp'
    if (expand('%:e') ==# 'cpp')
      find %:t:r.h
    else
      find %:t:r.cpp
    endif
  endif
endfunction

function! utils#StripTrailingWhitespaces() abort
    " Don't touch binary files or diff files
    if !&binary && &filetype !=# 'diff'
        let _s=@
        %s/\s\+$//e
        " restore last search to last search register, ignore above one
        let @/=_s
    endif
endfunction

function! utils#UpdateLastModified() abort
    " Looks for 'modified:' in first 10 lines and updates time. Called on
    " Bufwrite for *.vim in after/ftplugin. Saves pos and restores it too.
    if &filetype ==# 'vim'
      let l:winview = winsaveview()
      if exists('*strftime')
        silent! execute '1,10s/Modified:.*/Modified: ' . strftime('%Y-%m-%d') . '/'
        call winrestview(l:winview)
      else
        " Windows version using python3 fallback
        if has('python3')
py3 << EOF
import vim
from datetime import date
now = date.today()
newtime = now.strftime("%Y-%m-%d")
cb = vim.current.buffer
first_ten_lines = cb[1:10]
for line in first_ten_lines:
  if 'Modified:' in line:
    line.replace('Modified:', 'Modified: {}'.format(newtime))
EOF
        else
          echoerr 'Cannot update last modified time on this file because no python3 detected'
        endif
      endif
    endif
endfunction

function! utils#ToggleQuickfixList() abort
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~# "Quickfix List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      " is open, so close
      cclose
      return
    endif
  endfor
  let winnr = winnr()
  copen 5
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! utils#ToggleLocationList() abort
  let curbufnr = winbufnr(0)
  for bufnum in map(filter(split(s:GetBufferList(), '\n'), 'v:val =~# "Location List"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if curbufnr == bufnum
      lclose
      return
    endif
  endfor
  let winnr = winnr()
  let prevwinnr = winnr('#')
  let nextbufnr = winbufnr(winnr + 1)
  try
    lopen 5
  catch /E776/
      echohl ErrorMsg
      echo 'Location List is Empty.'
      echohl None
      return
  endtry
  if winbufnr(0) == nextbufnr
    lclose
    if prevwinnr > winnr
      let prevwinnr-=1
    endif
  else
    if prevwinnr > winnr
      let prevwinnr+=1
    endif
  endif
  " restore previous window
  exec prevwinnr.'wincmd w'
  exec winnr.'wincmd w'
endfunction

" Modified from github/milkypostman/vim-togglelist
function! s:GetBufferList() abort
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

" Return <CR>: and maybe followed by a 'b' or 'u' or more, depending on what
" the command requires to user to enter to work.
function! utils#MaybeReplaceCrWithCrColon() abort
  " https://gist.github.com/romainl/047aca21e338df7ccf771f96858edb86
  let l:cmdline = getcmdline()
  if l:cmdline =~ '\v\C^(ls|files|buffers)'
    return "\<CR>:b"
  elseif l:cmdline =~ '\v\C(#|nu|num|numb|numbe|number)$'
    return "\<CR>:"
  elseif l:cmdline =~ '\v\C^(dli|li)'
    return "\<CR>:" . cmdline[0] . "j " . split(cmdline, ' ')[1] . "\<S-Left>\<Left>"
  elseif cmdline =~ '\v\C^(cli|lli)'
    " like :clist or :llist but prompts for an error/location number
    return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
  elseif cmdline =~ '\C^old'
    " like :oldfiles but prompts for an old file to edit
    set nomore
    return "\<CR>:sil se more|e #<"
  elseif cmdline =~ '\C^changes'
    " like :changes but prompts for a change to jump to
    set nomore
    return "\<CR>:sil se more|norm! g;\<S-Left>"
  elseif cmdline =~ '\C^ju'
    " like :jumps but prompts for a position to jump to
    set nomore
    return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
  elseif cmdline =~ '\C^marks'
    " like :marks but prompts for a mark to jump to
    return "\<CR>:norm! `"
  elseif cmdline =~ '\C^undol'
    " like :undolist but prompts for a change to undo
    return "\<CR>:u "
  else
    return "\<CR>"
  endif
endfunction


function! utils#Hello() abort
  echo 'hello from autoload/utils.vim -> hello() function'
endfunction
