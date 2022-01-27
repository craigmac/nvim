setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=80
setlocal foldmethod=indent
" create 1 fold inside a function/endfunction, no more
setlocal foldnestmax=1
setlocal foldlevel=0

setlocal cinwords+=function!
setlocal cinwords+=abort
setlocal cinwords+=augroup
setlocal suffixesadd=.vim

nnoremap <silent><buffer> gf :call VimInclude()<CR>

" compiler vint
let &l:define = '\C^command\|^function'

" matches search (i.e. '/') string: call\s\+\zs\a\+#\a\+
setlocal include=call\\s\\+\\zs\\a\\+#\\a\\+

" Need to map gf to this to not consider directories to be valid gf
" candidates. For example, directory is .vim/pack/git/start/fzf.vim/plugin/fzf.vim 
" and vimrc has a :call fzf#run(..., and with default gf harcoded into vim,
" it would open the directory listing for fzf.vim (folder) rather than
" the actual fzf.vim (file).
function! VimInclude() abort
  " Uses value of local 'include'
  " echom 'Current line = ' .. getline('.')
  let l:fname = matchstr(getline('.')->trim(), &include)
  if empty(l:fname) | return | endif 
  " echom 'VimInclude fname matched is: ' .. l:fname
  let l:fnamesplit = split(l:fname, '#')
  let l:fname = l:fnamesplit[0]
  let l:funcname = l:fnamesplit[1]
  " echom 'VimInclude funcname if found or empty string: ' .. l:funcname
  " TODO: wrap in try in case file doesn't actually exist yet
  silent execute 'edit' findfile(l:fname .. &suffixesadd, &path)

  " TODO: wrap in try if function can't be found in existing file
  " 'w'rap around in the search bc other autocmd may set cursor further along
  " than the match in the file
  echom 'Not found! Is l:funcname non-existent? = ' .. l:funcname
  call search(l:funcname, 'w')
endfunction

" Provided v:fname will be the filename detected by 'include' regex 
setlocal includeexpr=VimInclude()
