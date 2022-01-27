" vim: fdm=marker nowrap ft=vim et sts=2 ts=2 sw=2 fdl=0

let mapleader = " "

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

" brew install fzf first
if executable('fzf') && has('mac')
    set runtimepath+=/usr/local/opt/fzf
endif

" Plugins in ./pack/third-party/opt
packadd! tagbar
packadd! vim-commentary
packadd! vim-fugitive
packadd! vim-repeat
packadd! vim-rhubarb
packadd vim-liquid | " no ! so ftdetect scripts are run
packadd! vim-surround
" TODO: eventually replace with Treesitter text objects?
packadd! vim-textobj-user
packadd! vim-textobj-entire
packadd! vim-textobj-indent
packadd! fzf.vim

" neovim-only
packadd! github-nvim-theme
packadd! plenary.nvim
" TODO: using fzf.vim until feature match possible
" packadd! telescope.nvim
" packadd! telescope-fzf-native.nvim
" packadd! telescope-ui-select.nvim
packadd! nvim-lspconfig
packadd! null-ls.nvim
packadd! nvim-cmp
packadd! cmp-nvim-lsp
packadd! cmp-path

" fzf.vim
nnoremap <C-p> :GFiles<CR>
" FZF from directory buffer is in, use this when not in Git repo
nnoremap <Leader>e. :FZF %:h<CR>
" Jump to buffer in existing window if possible with this option
let g:fzf_buffers_jump = 1
nnoremap <Leader><Tab> :Buffers<CR>

" Change to git project directory
nnoremap <Leader>c :FZFCd ~/git<CR>
nnoremap <Leader>C :FZFCd!<CR>
nnoremap <Leader><C-]> :Tags<CR>
command! -bang -bar -nargs=? -complete=dir FZFCd
  \ call fzf#run(fzf#wrap(
  \ {'source': 'find '.( empty("<args>") ? ( <bang>0 ? "~" : "." ) : "<args>" ) .' -type d',
  \ 'sink': 'cd'}))
" Function used to populate Quickfix with selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" Layout of fzf UI
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" Default toggle preview window key of <C-/> is not widely supported on
" terminal emulators. Also it slows things down. Off until toggled on.
let g:fzf_preview_window = ['right:60%:hidden', 'ctrl-o']
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['bg', 'Error'],
  \ 'fg+':     ['fg', 'Pmenu'],
  \ 'bg+':     ['bg', 'Pmenu'],
  \ 'hl+':     ['bg', 'Error'],
  \ 'info':    ['fg', 'Normal'],
  \ 'border':  ['fg', 'Normal'],
  \ 'prompt':  ['fg', 'Statement'],
  \ 'pointer': ['fg', 'Statement'],
  \ 'marker':  ['fg', 'Statement'],
  \ 'gutter':  ['bg', 'Normal'],
  \ 'spinner': ['fg', 'Label'],
  \ 'preview-fg': ['fg', 'Normal'],
  \ 'preview-bg': ['bg', 'Normal'],
  \ 'header':  ['fg', 'Comment'] }

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

set breakindent
set clipboard+=unnamedplus
set complete-=d
set completeopt=menuone
set diffopt+=algorithm:patience
set exrc
set foldlevelstart=99
set ignorecase smartcase
set listchars=tab:\│\ ,space:·,trail:·,eol:¬
set mouse=nvi
set nowrap
set number relativenumber
set path-=/usr/include |  set path+=**
set secure
set showmatch
" TODO: replace with a function call for finer grain
set statusline=\ %f | " buffer name relative to :pwd
set statusline+=%m%r%h | " [+] when modified, [-] no modify [RO] and [help]
set statusline+=%= | " Start right-hand side of statusline
set statusline+=%{FugitiveStatusline()}
set statusline+=\ [%Y]
set statusline+=\ %P
set statusline+=\ %l:%c\ 
set shortmess-=cS
set showtabline=2
set signcolumn=number
set splitbelow splitright
set tabline=%!utils#MyTabLine()
set tags=./tags;,tags;
set thesaurus=~/.config/nvim/thesaurus/english.txt
set termguicolors
set wildcharm=<C-z>
set wildignore=*.o,*.obj
set wildignore+=*.exe,*.dylib,%*
set wildignore+=*.png,*.jpeg,*.bmp,*.jpg
set wildignore+=*.pyc

if executable('git')
  set grepprg=git\ grep\ -Hnri\ 
else
  set grepprg=grep\ -Hnri
endif

let g:markdown_folding = 1

" }}}

" Mappings {{{

" manual expansions, when I want it
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

nnoremap <Leader><CR> :source %<CR>
nnoremap <Leader>w :update<CR>
nnoremap <Leader>, :edit $MYVIMRC<CR>
nnoremap <Leader>ft :e <C-R>=expand('~/.config/nvim/after/ftplugin/'.&ft.'.vim')<CR><CR>
nnoremap <Leader><Leader> :buffer #<CR>

" keeps marks, settings, and you can still do e.g., <C-o> to jump to it
nnoremap <Leader>dd <Cmd>bdelete!<CR> 
" REALLY delete the buffer.
nnoremap <Leader>D <Cmd>bwipeout!<CR>

" :find (&path aware) and :edit niceties
nnoremap <Leader>ff :find *
nnoremap <Leader>fs :sfind *
nnoremap <Leader>fv :vert sfind *

" Tab-expand to show wildmenu then untab to unselect but still see menu
nnoremap <Leader>ee :edit *<C-z><S-Tab>
nnoremap <Leader>es :split *<C-z><S-Tab>
nnoremap <Leader>ev :vert split *<C-z><S-Tab>

" Tmux-like mappings
" TODO: start in insert mode and close when exited
nnoremap <C-b>s :terminal<CR>
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
nnoremap <silent><S-Up> <Cmd>2wincmd+<CR>
nnoremap <silent><S-Down> <Cmd>2wincmd-<CR>
nnoremap <silent><S-Left> <Cmd>2wincmd <<CR>
nnoremap <silent><S-Right> <Cmd>2wincmd ><CR>

" Re-select visually selected area after indenting/dedenting.
xmap < <gv
xmap > >gv

" Move visual selection up/down lines.
xnoremap J :m '>+1<CR>gv=gv
xnoremap K :m '<-2<CR>gv=gv

nnoremap <silent> [l :silent! lprevious<CR>
nnoremap <silent> ]l :silent! lnext<CR>
"
" '%%' in command-line mode maybe expands to path of current buffer.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Function keys
nnoremap <silent><F3> :call utils#ToggleQuickfixList()<CR>
nnoremap <silent><F4> :call utils#ToggleLocationList()<CR>
nnoremap <silent><F7> :15Lexplore<CR>
nnoremap <silent><F8> :TagbarOpenAutoClose<CR>
nnoremap <silent>gO :TagbarOpenAutoClose<CR>
nnoremap <silent><F9> :set list!<CR>
nnoremap <silent><F10> :set spell!<CR>
nnoremap <silent><Leader>* :grep <cword><CR>

" Vimdiff
nnoremap gh :diffget //2<CR>
nnoremap gl :diffget //3<CR>

" vim-unimpaired style
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprev<CR>
nnoremap ]T :tablast<CR>
nnoremap [t :tabfirst<CR>

nnoremap g; g;zv
nnoremap g, g,zv
nnoremap <silent> } :keepjumps normal! }<CR>
nnoremap <silent> { :keepjumps normal! {<CR>

nmap <Leader>/ :grep<Space>
nnoremap <Leader>? :vimgrep //j **/*.md<S-Left><S-Left><Right>

nnoremap <Leader>@ :JekyllOpen<CR> 

" }}}

" Commands {{{

command! Api :help list-functions<CR>
command! Cd :lcd %:h
command! TodoLocal :botright silent! lvimgrep /\v\CTODO|FIXME|HACK|DEV/ %<CR>
command! Todo :botright silent! vimgrep /\v\CTODO|FIXME|HACK|DEV/ *<CR>
command! JekyllOpen call utils#JekyllOpenLive()

" https://vi.stackexchange.com/questions/13433/how-to-load-list-of-files-in-commit-into-quickfix
command! -nargs=? -bar Gshow call setqflist(map(systemlist("git show --pretty='' --name-only <args>"), '{"filename": v:val, "lnum": 1}')) | copen

" Check out PR # using gh pr checkout command and completion
command! -complete=customlist,Ghlistprs -nargs=1 Ghprcheckout silent! !gh pr checkout <args>
function! Ghlistprs(ArgLead, CmdLine, CursorPos) abort
  return systemlist('gh pr list | cut -f1')
endfunction

" }}}

" Autocmd {{{
" Put all autocmds into this group so this file is
" safe to be re-sourced, by clearing all first with autocmd!
augroup myinit
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
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
  autocmd BufWinEnter * if &previewwindow | setlocal nonumber norelativenumber nolist | endif
augroup END

" }}}

" Colors/UI {{{

let g:github_dark_float = 1
let g:github_comment_style = 'italic'
let g:github_keyword_style = 'NONE'
let g:github_function_style = 'NONE'
let g:github_variable_style = 'NONE'
colorscheme github_light
" TODO: look up the proper way to guard this in romainl gist
hi! StatusLineNC guibg=#dddddd gui=NONE

" }}}

