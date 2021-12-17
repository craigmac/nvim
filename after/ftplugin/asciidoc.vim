" ftplugin/asciidoc.vim
" 2020-04-23
" C.D. MacEachern <craigm@fastmail.com>

" 'dts' expands to current date e.g., 2020-04-23
iabbrev <expr> dts strftime('%Y-%m-%d')

iabbrev hdr [[header-name]]
      \<CR>= Header Name
      \<CR>Craig MacEachern 
      \<CR>2020-04-23
      \<CR>:toc:
      \<CR>:sectanchors:
      \<CR>:sectlinks:

iabbrev stub [[article-stub]]
      \<CR>= Article Stub
      \<CR>Craig MacEachern
      \<CR>2020-04-23
      \<CR>:toc:
      \<CR>:sectanchors:
      \<CR>:sectlinks:
      \<CR>
      \<CR>= What
      \<CR>
      \<CR>= Why
      \<CR>
      \<CR>= Where/When
      \<CR>
      \<CR>= Who
      \<CR>
      \<CR>= Examples
      \<CR>
      \<CR>= Further Readings/links
      \<CR>

function! AsciidocUpdateModifiedinHeader() abort
  silent! execute '1,10s/\v\d{4}-\d{2}-\d{1,2}/'.strftime('%Y-%m-%d').'/'
endfunction

augroup LocalAsciiDocTimeUpdate
  autocmd!
  autocmd  BufWritePre *.adoc,*.asciidoc call AsciidocUpdateModifiedinHeader()
augroup END

