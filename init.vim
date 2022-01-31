" Plugins {{{

" defaults I never use
let g:loaded_getscriptPlugin = 1
let g:loaded_logiPat = 1
let g:loaded_vimballPlugin = 1
let g:loaded_vimball = 1
let g:loaded_zipPlugin = 1
let g:loaded_gzip = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_2html_plugin = 1
packadd! cfilter

" Plugins in ./pack/third-party/opt
packadd! tagbar
packadd! vim-commentary
packadd! vim-fugitive
packadd! vim-repeat
packadd! vim-rhubarb
packadd! vim-surround
" TODO: eventually replace with Treesitter text objects?
packadd! vim-textobj-user
packadd! vim-textobj-entire
packadd! vim-textobj-indent

packadd! github-nvim-theme
packadd! plenary.nvim
packadd! telescope.nvim
packadd! telescope-fzf-native.nvim
packadd! telescope-ui-select.nvim
packadd! telescope-github.nvim
packadd! nvim-lspconfig
packadd! null-ls.nvim
packadd! nvim-cmp
packadd! cmp-nvim-lsp
packadd! cmp-path
packadd! nvim-treesitter
packadd! nvim-treesitter-textobjects
packadd! lualine.nvim

" vim-fugitive
nnoremap <silent><Leader>gg :G<CR>
noremap <silent><Leader>gb :G blame<CR>
nnoremap <silent><Leader>gl :Gclog<CR>
nnoremap <silent><Leader>gc :G commit -av<CR>
nnoremap <silent><Leader>gd :Gvdiffsplit<CR>
nnoremap <Leader>g/ :Ggrep! -Hnri --quiet<Space>
nnoremap <silent><Leader>gP :G push<CR>
nnoremap <silent><Leader>gp :G pull<CR>
" Requires vim-rhubarb, visual selection appends anchors to URL to highlight
" Reminder: ["x]y<C-g> to yank relative path to clipboard
" Reminder: :GBrowse! doesn't open URL just yanks it to clipboard
nnoremap <Leader>g@ :GBrowse<CR>
xnoremap <Leader>g@ :GBrowse<CR>

" }}}

" Options {{{

let mapleader = " "

set breakindent
set clipboard+=unnamedplus
set complete-=d completeopt=menuone
set diffopt+=algorithm:patience
set exrc secure
" Experimental, per-window, not per-buffer
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set grepprg=grep\ -Hnri
set ignorecase smartcase
set listchars=tab:\│\ ,space:·,trail:·,eol:¬
set mouse=a
set nowrap
set number 
set path-=/usr/include |  set path+=**
set showmatch
set shortmess-=cS
set showtabline=2
set signcolumn=yes
set splitbelow splitright
set tabline=%!utils#MyTabLine()
set tags=./tags;,tags;
set termguicolors

" }}}

" Mappings {{{

inoremap <C-Space> <C-x><C-o>

inoremap (<CR> (<CR>)<Esc>O
inoremap (; (<CR>);<Esc>O
inoremap (, (<CR>),<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [; [<CR>];<Esc>O
inoremap [, [<CR>],<Esc>O

" e.g. typing ':help g<C-p>' by default does not search history and simply
" goes to previous entry, but ':help g<Up>' will search history for previous
" pattern matching ':help g'. Also Up/Down go in/out of subfolders listings
" when wildmenu showing - default C-n/p here is to traverse results, equivalent
" to <Tab>/<S-Tab>. 
cnoremap <expr> <C-p> wildmenumode() ? "<C-P>" : "<Up>"
cnoremap <expr> <C-n> wildmenumode() ? "<C-N>" : "<Down>"

" If completion menu open use C-j/k instead of arrow keys to navigate
" parent/child folders.
cnoremap <expr> <C-j> wildmenumode() ? "\<Down>\<C-z>" : "\<C-j>"
cnoremap <expr> <C-k> wildmenumode() ? "\<Up>\<C-z>" : "\<C-k>"

nnoremap <Leader><CR> <cmd>source %<CR>
nnoremap <Leader>w <cmd>update<CR>
nnoremap <Leader>, <cmd>edit $MYVIMRC<CR>
nnoremap <Leader>ft :e <C-R>=expand('~/.config/nvim/after/ftplugin/'.&ft.'.vim')<CR><CR>
nnoremap <Leader><Leader> <cmd>buffer #<CR>

" keeps marks, settings, and you can still do e.g., <C-o> to jump to it
nnoremap <Leader>dd <Cmd>bdelete!<CR> 
" REALLY delete the buffer.
nnoremap <Leader>D <Cmd>bwipeout!<CR>

" Tmux-like mappings
" TODO: start in insert mode and close when exited
nnoremap <C-b>s :split +terminal<CR>
nnoremap <C-b>v :vsplit +terminal<CR>
nnoremap <C-b>! <C-w>T
tnoremap <C-b>s :terminal<CR>
tnoremap <C-b>v :vsplit +terminal<CR>
tnoremap <C-b>! <C-w>T

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-\><C-n><C-w>h
nnoremap <A-j> <C-\><C-n><C-w>j
nnoremap <A-k> <C-\><C-n><C-w>k
nnoremap <A-l> <C-\><C-n><C-w>l

" resizing windows
nnoremap <silent><C-Up> <Cmd>2wincmd+<CR>
nnoremap <silent><C-Down> <Cmd>2wincmd-<CR>
nnoremap <silent><C-Left> <Cmd>2wincmd <<CR>
nnoremap <silent><C-Right> <Cmd>2wincmd ><CR>

" Re-select visually selected area after indenting/dedenting.
xmap < <gv
xmap > >gv

" Move visual selection up/down lines.
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv

" '%%' in command-line mode maybe expands to path of current buffer.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Function keys
nnoremap <silent><F3> <cmd>call utils#ToggleQuickfixList()<CR>
nnoremap <silent><F4> <cmd>call utils#ToggleLocationList()<CR>
nnoremap <silent><F7> <cmd>15Lexplore<CR>
nnoremap <silent><F8> <cmd>TagbarOpenAutoClose<CR>
nnoremap <silent><F9> <cmd>set list!<CR>
nnoremap <Leader>* :grep <C-r><C-w> 

" Vimdiff
nnoremap gh :diffget //2<CR>
nnoremap gl :diffget //3<CR>

nnoremap [q <cmd>cprevious<CR>
nnoremap ]q <cmd>cnext<CR>
nnoremap [Q <cmd>cfirst<CR>
nnoremap ]Q <cmd>clast<CR>
nnoremap [e <cmd>lprevious<CR>
nnoremap ]e <cmd>lnext<CR>
nnoremap ]E <cmd>llast<CR>
nnoremap [E <cmd>lfirst<CR>
nnoremap ]t <cmd>tabnext<CR>
nnoremap [t <cmd>tabprev<CR>
nnoremap ]T <cmd>tablast<CR>
nnoremap [t <cmd>tabfirst<CR>

nnoremap g; g;zv
nnoremap g, g,zv
nnoremap <silent> } <cmd>keepjumps normal! }<CR>
nnoremap <silent> { <cmd>keepjumps normal! {<CR>

nmap <Leader>/ :grep<Space>
nnoremap <Leader>? :vimgrep //j **/*.md<S-Left><S-Left><Right>

nnoremap <Leader>@ <cmd>JekyllOpen<CR> 

" }}}

" Commands {{{

command! Api :help list-functions<CR>
command! Cd :lcd %:h
command! TodoLocal :botright silent! lvimgrep /\v\CTODO|FIXME|HACK|DEV/ %<CR>
command! Todo :botright silent! vimgrep /\v\CTODO|FIXME|HACK|DEV/ *<CR>
command! JekyllOpen call utils#JekyllOpenLive()

" }}}

" Autocmd {{{

augroup myinit
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC | setlocal fdm=marker
  autocmd BufWritePre /tmp/* setlocal noundofile
  autocmd QuickFixCmdPost [^l]* botright cwindow
  autocmd QuickFixCmdPost  l* botright lwindow
  autocmd VimEnter * cwindow
  autocmd FileType gitcommit call feedkeys('i')
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
  " I also set this in utils#Redir because it does 'nobuflisted'
  " This one catches other things that open 'nofile' buffers
  autocmd BufEnter * if &buftype ==# 'nofile' | nnoremap <buffer> q :bwipeout!<CR> | endif
  autocmd BufEnter * if &buftype ==# 'nofile' | setlocal nocursorcolumn | endif
  autocmd BufEnter $MYVIMRC setlocal fdm=marker
  autocmd BufWinEnter * if &previewwindow | setlocal nonumber norelativenumber nolist | endif
  autocmd TermOpen * startinsert | setlocal nonumber norelativenumber
  autocmd TermOpen * setlocal statusline=%{b:term_title}
  " Auto close terminal buffers if exit status was 0 (no errors)
  autocmd TermClose * if !v:event.status | execute 'bdelete! ' .. expand('<abuf>') | endif
  autocmd BufEnter term://* startinsert
augroup END

" }}}

" Colors/UI {{{

function! GithubLightHighlights() abort
  " Called by autocmd in augroup MyColorOverrides when colorscheme
  " switched to 'github_light'
  " Idea from:
  " https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
  highlight! link DiagnosticFloatingWarn Normal
  highlight! link DiagnosticFloatingInfo Normal
  highlight! link DiagnosticFloatingHint Normal
  highlight! link DiagnosticFloatingError Normal
  highlight! DiagnosticUnderlineWarn gui=undercurl guisp=Orange
  highlight! DiagnosticUnderlineInfo gui=undercurl guisp=LightBlue
  highlight! DiagnosticUnderlineHint gui=undercurl guisp=LightGrey
  highlight! DiagnosticUnderlineError gui=undercurl guisp=Red
  highlight! SpellBad gui=undercurl guisp=Blue
  highlight! SpellRare gui=undercurl guisp=Blue
  highlight! SpellCap gui=undercurl guisp=Blue
  highlight! SpellLocal gui=undercurl guisp=Blue
endfunction

augroup MyColorOverrides
  autocmd!
  autocmd ColorScheme github_light call GithubLightHighlights()
augroup END

let g:github_hide_inactive_statusline = 0
let g:github_dark_float = 0
let g:github_comment_style = 'italic'
let g:github_keyword_style = 'NONE'
let g:github_function_style = 'NONE'
let g:github_variable_style = 'NONE'
let g:github_hide_end_of_buffer = 0
colorscheme github_light

" }}}

lua require"my.config"
