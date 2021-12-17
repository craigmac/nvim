-- Bare basics
local silentnoremap = { noremap = true, silent = true }
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', silentnoremap)
vim.g.mapleader = ' '

vim.opt.clipboard = { 'unnamed', 'unnamedplus' }
vim.opt.completeopt = { 'menuone', 'noselect' }
vim.opt.exrc = true
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.listchars = { space = '·', trail = '·', tab = '→ ' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:remove { '/usr/include' }
vim.opt.path:append { '**' }
vim.opt.relativenumber = true
-- So I can use autocmds in exrc project files
vim.opt.secure = false
vim.opt.showmatch = true
--vim.opt.statusline = '%F'
--vim.opt.statusline = vim.opt.statusline + "%="
--vim.opt.statusline = vim.opt.statusline + "%y"
vim.opt.shortmess:remove { 'c', 'S' }
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- statusline
-- %<                                             trim from here
-- %{fugitive#head()}                             name of the current branch (needs fugitive.vim)
-- %f                                             path+filename
-- %m                                             check modifi{ed,able}
-- %r                                             check readonly
-- %w                                             check preview window
-- %=                                             left/right separator
-- %l/%L,%c                                       rownumber/total,colnumber
-- %{&fileencoding?&fileencoding:&encoding}       file encoding
-- Requires a Nerdfont, remember to use BlexMono Nerd Font Mono (based on IBM Plex Mono)
vim.opt.statusline =
    "  %< %{fugitive#head()}  %f %m %r %w %= Ln %l, Col %c  %{&fileencoding?&fileencoding:&encoding}  "
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.thesaurus = "~/.config/nvim/thesaurus/english.txt"
vim.opt.wrap = false
