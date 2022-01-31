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

" https://vi.stackexchange.com/questions/13433/how-to-load-list-of-files-in-commit-into-quickfix
command! -nargs=? -bar Gshow call setqflist(map(systemlist("git show --pretty='' --name-only <args>"), '{"filename": v:val, "lnum": 1}')) | copen

" }}}

" Autocmd {{{
" Put all autocmds into this group so this file is
" safe to be re-sourced, by clearing all first with autocmd!
augroup myinit
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
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
  autocmd TermOpen * startinsert | setlocal nonumber norelativenumber
  autocmd TermOpen * setlocal statusline=%{b:term_title}
  " Auto close terminal buffers if exit status was 0 (no errors)
  autocmd TermClose * if !v:event.status | execute 'bdelete! ' .. expand('<abuf>') | endif
  autocmd BufEnter term://* startinsert
augroup END

" }}}

" Colors/UI {{{

let g:github_hide_inactive_statusline = 0
let g:github_dark_float = 0
let g:github_comment_style = 'italic'
let g:github_keyword_style = 'NONE'
let g:github_function_style = 'NONE'
let g:github_variable_style = 'NONE'
let g:github_hide_end_of_buffer = 0
colorscheme github_light

hi! link DiagnosticFloatingWarn Normal
hi! link DiagnosticFloatingInfo Normal
hi! link DiagnosticFloatingHint Normal
hi! link DiagnosticFloatingError Normal

hi! DiagnosticUnderlineWarn gui=undercurl guisp=Orange
hi! DiagnosticUnderlineInfo gui=undercurl guisp=LightBlue
hi! DiagnosticUnderlineHint gui=undercurl guisp=LightGrey
hi! DiagnosticUnderlineError gui=undercurl guisp=Red

hi! SpellBad gui=undercurl guisp=Blue
hi! SpellRare gui=undercurl guisp=Blue
hi! SpellCap gui=undercurl guisp=Blue
hi! SpellLocal gui=undercurl guisp=Blue

" }}}

" Lua {{{

lua << EOF

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
  completion = {
    autocomplete = false,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  },
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
	}),
})

-- Inside foo.setup() for each language server config, we
-- pass this to 'on_attach' function to run after connected to server. 
local my_on_attach = function(client)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])

  vim.api.nvim_buf_set_option(0, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_buf_set_option(0, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = 0})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = 0})
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = 0})
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { buffer = 0})
  vim.keymap.set('n', 'g.', "<cmd>Telescope lsp_code_actions<CR>", { buffer = 0})
  vim.keymap.set('n', 'gO', "<cmd>Telescope lsp_document_symbols<CR>", { buffer = 0})
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = 0})
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = 0})
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = 0})
  vim.keymap.set('n', 'gq', vim.lsp.buf.formatting, { buffer = 0})
  vim.keymap.set('n', '<F4>', vim.diagnostic.setloclist, { buffer = 0})
end

-- Lua language server (sumneko)
local sumneko_root_path = '/Users/cmaceach/git/lsp-servers/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/".."/lua-language-server"
require('lspconfig').sumneko_lua.setup({
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
  on_attach = my_on_attach,
  capabilities = my_capabilities,
})

-- null-ls setup
require("null-ls").setup({
	debug = false,
	sources = {
		-- For Lua, sumneko-lua server doesn't support formatting
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.vale,
		require("my.null_ls_custom.markdownlint_cli2"),
	},
	on_attach = my_on_attach,
  capabilities = my_capabilities,
})

-- telescope.nvim
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local layouts = require("telescope.actions.layout")
local pickers = require("telescope.pickers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
require("telescope").setup({
	defaults = {
		path_display = { "absolute" },
		mappings = {
			i = {
				["<C-o>"] = layouts.toggle_preview,
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,
			},
		},
	},
	pickers = {
		-- change configs for each builtin picker (each key is a picker name)
		git_files = {
			theme = "dropdown",
			previewer = false,
		},
		spell_suggest = {
			theme = "cursor",
		},
		grep_string = {
			theme = "dropdown",
			previewer = false,
		},
		live_grep = {
			theme = "dropdown",
			previewer = false,
		},
		lsp_code_actions = {
			theme = "cursor",
		},
		find_files = {
			theme = "dropdown",
			previewer = false,
		},
		buffers = {
			theme = "dropdown",
			previewer = false,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

-- TODO: try out nvim-telescope/telescope-github.nvim
-- these need to come after main setup() call
require("telescope").load_extension("fzf")
-- sets vim.ui.select to use telescope so things like vim.lsp.buf.code_action()
-- will use telescope interface instead
require("telescope").load_extension("ui-select")
require("telescope").load_extension('gh')


vim.keymap.set("n", "<C-p>", require('telescope.builtin').git_files)
vim.keymap.set("n", "<Leader>ff", require('telescope.builtin').find_files)
vim.keymap.set("n", "<Leader><Tab>", require('telescope.builtin').buffers)
vim.keymap.set("n", "<Leader><F1>", require('telescope.builtin').help_tags)
vim.keymap.set("n", "<Leader><C-]>", require('telescope.builtin').tags)
vim.keymap.set("n", "<Leader>:", require('telescope.builtin').commands)
vim.keymap.set("n", "z=", require('telescope.builtin').spell_suggest)
vim.keymap.set("n", '<Leader>"', require('telescope.builtin').registers)

-- treesitter.nvim
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "gn",
			scope_incremental = "gs",
			node_decremental = "gp",
		},
	},
	indent = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- jump ahead like targets.vim did
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = false, -- whether to add jump to jumplist (:jumps)
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
})

-- vim.diagnostic settings
-- TODO: popup shown on mouse hover 
vim.diagnostic.config({ 
  virtual_text = false,
  underline = true,
  signs = false,
  float = {
    scope = 'cursor',
    source = false,
    header = '',
    border = 'double',
  },
})

-- lualine.nvim
-- TODO: add truncation of parts for <81 chars width:
-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#truncating-components-in-smaller-window
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "github",
		always_divide_middle = true,
	},
	sections = {
    -- If I want to see single char showing  current mode:
		--lualine_a = {
		--	{
		--		"mode",
		--		fmt = function(str)
		--			return str:sub(1, 1)
		--		end,
		--	},
		--},
    lualine_a = {},
		lualine_b = { "branch", "diagnostics" },
		lualine_c = { "%f" },
		lualine_x = {},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "%f" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

EOF

" }}}
