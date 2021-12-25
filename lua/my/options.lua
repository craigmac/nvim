local o = vim.opt

o.clipboard = { 'unnamed', 'unnamedplus' }
o.complete:remove { "d" }
o.completeopt = { 'menuone', 'noselect' }
o.diffopt:append { 'algorithm:patience' }
o.exrc = true
o.foldlevelstart = 99
o.ignorecase = true
o.iskeyword:append { '-' }
o.listchars = { space = '·', trail = '·', tab = '→ ' }
o.mouse = 'a'
o.number = true
o.path:remove { '/usr/include' }
o.path:append { '**' }
o.relativenumber = true
o.secure = false
o.showmatch = true
o.shortmess:remove { 'c', 'S' }
o.signcolumn = 'yes'
o.smartcase = true
o.smartindent = true
o.splitbelow = true
o.splitright = true
o.statusline =
    "%F %m %r %w %< %{fugitive#head()} %=  %l/%L:%c %{&fileencoding?&fileencoding:&encoding}  "
o.swapfile = false
o.termguicolors = true
o.thesaurus = "~/.config/nvim/thesaurus/english.txt"
o.updatetime=300
o.wrap = false

-- TODO: is it possible to use K in lua files to open e.g., :help <cword> like .vim files?
-- might have to use an expr mapping to determing if what comes before cword is something
-- like 'o' (although user can alias anything so this is best we can do?)
-- TODO: only show git branch icon if fugitive#head() is not null
-- TODO: move my old set tabline=%!MyTabLine() and functions

-- TODO: does tmux on alacritty with neovim work without this?
-- if exists('+termguicolors')
--   " To work with tmux we needs these as well
--   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
--   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
-- endif
