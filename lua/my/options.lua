vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { silent = true, noremap = true })
vim.g.mapleader = " "

vim.opt.breakindent = true
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.complete:remove({ "d" })
vim.opt.completeopt = { "menuone" }
vim.opt.diffopt:append({ "algorithm:patience" })
vim.opt.exrc = true
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.iskeyword:append({ "-" })
vim.opt.listchars = { space = "·", trail = "·", tab = "→ " }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.path:remove({ "/usr/include" })
vim.opt.path:append({ "**" })
vim.opt.relativenumber = true
vim.opt.secure = false
vim.opt.showmatch = true
vim.opt.shortmess:remove({ "c", "S" })
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.thesaurus = "~/.config/nvim/thesaurus/english.txt"
vim.opt.updatetime = 250
vim.opt.wrap = false
