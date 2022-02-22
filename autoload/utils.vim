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

function! utils#JekyllOpenLive() abort
  " Requires 'devx' as &pwd for '%:.' to work correctly with forming the final URL to open
  if !getcwd() =~ 'devx' 
    echoerr 'Command only works when &pwd is "devx"'
    return
  endif
  let relpath = expand('%:.')
        \ ->substitute('_ver_', '', '')
        \ ->substitute('^docs', '', '')
        \ ->substitute('\.md$', '/', '')

  " cases:
  " docs/_ver_6.14/path/to/file
  " docs/release-details/file-with-version-6.8.md
  let newversion = relpath->matchstr('\d\.\d\d\?')

  " When relpath = version/path/to/topic we need to drop leading \d\.\d\d\? dir, otherwise we end
  " up with 6.15/6.15/path/to/file. We only check up to first / to limit to first folder.
  let newpath = newversion .. relpath->substitute('\d\.\d\d\?/', '', '')

  " any version 6.14 and over requires localhost only
  let host = str2float(newversion) >= 6.14 ? 'http://127.0.0.1:4000/' : 'https://developer-staging.youi.tv/'

  let finalurl = host .. newpath
  " TODO: make more robust, calling os-specific open like netrw does,
  " like xdg-open on Linux
  execute "silent! !open " . finalurl
endfunction

function! utils#Redir(cmd) abort
  echom 'Received: ' .. a:cmd
  let output = execute(a:cmd)
  botright split +enew
  setlocal nobuflisted nonumber norelativenumber buftype=nofile bufhidden=wipe noswapfile
  nnoremap <buffer> q :bwipeout!<CR>
  call setline(1, split(output, "\n"))
endfunction

" NOTES: false positives currently for .zip/.pdf/.html links because we
" chop at the first period found (to remove the .md)
function! utils#MarkdownInclude() abort
  " finds:
  " '/snippets/target-platform-before-start'
  " '/cpp/platform-roku/roku-cloud-solution/'
  " '/rn/develop/focus-management/#why-we-need-focus'
  " '(../windows/)
  " echom 'Using include value of: ' .. &include
  let l:fname = matchstr(getline('.')->trim(), &include)
  if empty(l:fname) 
    return 
  endif 

  " echom 'l:fname after trim() and include match = ' .. l:fname

  " split any #foo so we can jump to that spot in the file if it exists
  let l:fname_ahref = split(l:fname, '#')
  let l:fname = l:fname_ahref[0]
  try
    let l:ahref = l:fname_ahref[1]
  catch /E684/
    let l:ahref = 0
  endtry

  " echom 'l:fname_ahref if found in include match = ' .. l:ahref

  " trim any trailing / so we can use suffixesadd to add .md
  let l:fname = substitute(l:fname, '/$', '', '')
  " trim leading / as well
  let l:fname = substitute(l:fname, '^/', '', '')

  " echom 'l:fname after leading and trailing "/" removed = ' .. l:fname

  " TODO: 
  " now get what version folder we want to start search in
  " from the buffer name we are in, hardcoded right now for 6.15 only
  let l:search_path = '/Users/cmaceach/git/devx/docs/_ver_' .. '6.15' .. '/**'

  " echom 'using l:search_path of : ' .. l:search_path

  execute 'edit ' .. findfile(l:fname .. &suffixesadd, l:search_path)

  " try jumping to href tag if one was found
  if !empty(l:ahref)
    " remove dashes in the line, which are used in the url,
    let l:ahref = substitute(l:ahref, '-\+', ' ', 'g')
    call search('^#\+\s*' .. l:ahref, 'w')
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

function! utils#MyTabLine() abort
  " Loop over pages and define labels for them, then get label for each tab
  " page use MyTabLabel(). See :h 'statusline' for formatting, e.g., T, %, #, etc.
  function! MyTabLabel(n)
    " Give tabpage number n create a string to display on tabline
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    " return getcwd(winnr)
    return getcwd(winnr, a:n)
    " return bufname(buflist[winnr - 1])
  endfunction
  let s = ''
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      " use hl-TabLineSel for current tabpage
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number, for mouse clicks
    let s .= '%' . (i + 1) . 'T'

    " call MyTabLabel() to make the label
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " After last tab fill with hl-TabLineFill and reset tab page nr with %T
  let s .= '%#TabLineFill#%T'

  " Right-align (%=) hl-TabLine (%#TabLine#) style and use %999X for a close
  " current tab mark, with 'X' as the character
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999XX'
  endif

  return s
endfunction

