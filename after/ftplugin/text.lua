vim.cmd([[
" end of this pattern match is used as the indent width for line below it when using 'n' flag in formatoptions
setlocal formatlistpat=^\s*[•\*]\s.
" recognize (n)umbered lists (actually, it uses 'formatlistpat' pattern)
setlocal formatoptions+=n

" reset options if filetype is changed to their global values
let b:undo_ftplugin = 'setlocal formatoptions< formatlistpat<'
]])


