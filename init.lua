-- Neovim 0.6+ configuration

-- Utilities
local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }
map('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '

-- Options
vim.opt.breakindent = true
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }
vim.opt.complete:remove { 'd' }
vim.opt.completeopt = { 'menuone' }
vim.opt.diffopt:append { 'algorithm:patience' }
vim.opt.exrc = true
vim.opt.foldlevelstart = 99
vim.opt.ignorecase = true
vim.opt.iskeyword:append { '-' }
vim.opt.listchars = { space = '·', trail = '·', tab = '→ ' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.path:remove { '/usr/include' }
vim.opt.path:append { '**' }
vim.opt.relativenumber = true
vim.opt.secure = false
vim.opt.showmatch = true
vim.opt.shortmess:remove { 'c', 'S' }
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.thesaurus = '~/.config/nvim/thesaurus/english.txt'
vim.opt.updatetime = 250
vim.opt.wrap = false

-- Packer
require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }
  use { 'nvim-telescope/telescope.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'numToStr/Comment.nvim' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
  use { 'neovim/nvim-lspconfig' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-path' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'L3MON4D3/LuaSnip' }
  use { 'rafamadriz/friendly-snippets', after = 'LuaSnip' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat', after = 'vim-surround' }
  use 'lunarvim/darkplus.nvim'
  use { 'nvim-lualine/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use 'kdheepak/lazygit.nvim'
end)

-- Keymaps
map('n', '<Leader>w', ':update<CR>', opts)
map('n', '<Leader>,', ':edit ~/.config/nvim/init.lua<CR>', opts)
map('n', '<Leader>gg', '<Cmd>LazyGit<CR>', opts)
map('n', ']q', ':cnext<CR>', opts)
map('n', ']Q', ':clast<CR>', opts)
map('n', '[q', ':cprevious<CR>', opts)
map('n', '[Q', ':cfirst<CR>', opts)
map('n', ']l', ':lnext<CR>', opts)
map('n', ']L', ':llast<CR>', opts)
map('n', '[l', ':lprevious<CR>', opts)
map('n', '[L', ':lfirst<CR>', opts)
map('v', '>', '>gv', opts)
map('v', '<', '<gv', opts)
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)
map('n', '<M-j>', '<C-w>p<C-e><C-w>p', opts)
map('n', '<M-k>', '<C-w>p<C-y><C-w>p', opts)
map('n', '<M-J>', '<C-w>p<C-d><C-w>p', opts)
map('n', '<M-K>', '<C-w>p<C-u><C-w>p', opts)
map('n', '<Leader><Leader>', '<Cmd>buffer #<CR>', opts)
map('n', '<Leader>k', '<Cmd>bdelete!<CR>', opts)
vim.cmd [[
" Function keys
nnoremap <F3> :call utils#ToggleQuickfixList()<CR>
nnoremap <F4> :call utils#ToggleLocationList()<CR>
nnoremap <F5> :silent make! % <bar> silent redraw!<CR>
nnoremap <F6> :15Lexplore<CR>
nnoremap <F9> :set list!<CR>
nnoremap <F10> :set spell!<CR>
nnoremap <Leader>ft :e <C-R>=expand('~/.vim/after/ftplugin/'.&ft.'.vim')<CR><CR>
nnoremap gh :diffget //2<CR>
nnoremap gl :diffget //3<CR>
cnoremap <expr> <C-n> wildmenumode() ? '<C-n>' : '<Down>'
cnoremap <expr> <C-p> wildmenumode() ? '<C-p>' : '<Up>'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
]]

-- Autocommands
vim.cmd [[
augroup my_autocommands
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost  l* lwindow
augroup END
]]

-- Colors
vim.cmd [[ colorscheme darkplus ]]

-- Plugin Configuration

-- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
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
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = false, -- whether to add jump to jumplist (:jumps)
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- nvim-cmp
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip/loaders/from_vscode').lazy_load()
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    autocomplete = false,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm { select = false },
    ['<Tab>'] = function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- nvim-lspconfig
local lspconfig = require 'lspconfig'
vim.diagnostic.config { virtual_text = false }
local my_on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<Leader>gq', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local servers = { 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = my_on_attach,
    capabilities = capabilities,
  }
end

-- lua-language-server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
lspconfig.sumneko_lua.setup {
  on_attach = my_on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
    },
  },
}

-- null-ls
local null_ls = require 'null-ls'
local sources = {
  null_ls.builtins.formatting.stylua,
  null_ls.builtins.diagnostics.vale,
  require 'my.null_ls_custom.markdownlint_cli2',
}
null_ls.setup {
  on_attach = my_on_attach,
  sources = sources,
}

-- telescope.nvim
require('telescope').setup {
  defaults = {
    path_display = { 'absolute' },
    mappings = {
      i = {
        -- TODO: fix this one
        -- ["<esc>"] = require'telescope.actions.close',
        ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
      },
    },
  },
  pickers = {
    git_files = {
      theme = 'dropdown',
      previewer = false,
      prompt_title = false,
    },
    find_files = {
      theme = 'dropdown',
    },
    buffers = {
      theme = 'ivy',
      prompt_title = false,
    },
    spell_suggest = {
      theme = 'cursor',
    },
    help_tags = {
      theme = 'dropdown',
    },
    live_grep = {
      theme = 'dropdown',
    },
    tags = {
      theme = 'dropdown',
    },
    grep_string = {
      theme = 'ivy',
    },
    lsp_code_actions = {
      theme = 'cursor',
    },
  },
  extensions = {},
}
require('telescope').load_extension 'fzf'
map('n', '<C-p>', '<Cmd>Telescope git_files<CR>', opts)
map('n', '<Leader>e', '<Cmd>Telescope find_files<CR>', opts)
map('n', '<Leader>b', '<Cmd>Telescope buffers<CR>', opts)
map('n', '<Leader><F1>', '<Cmd>Telescope help_tags<CR>', opts)
map('n', '<Leader>/', '<Cmd>Telescope live_grep<CR>', opts)
map('n', '<Leader><C-]>', '<Cmd>Telescope tags<CR>', opts)
map('n', '<Leader>?', '<Cmd>Telescope grep_string<CR>', opts)
map('n', 'z=', '<Cmd>Telescope spell_suggest<CR>', opts)
map('n', '<M-.>', '<Cmd>Telescope lsp_code_actions<CR>', opts)
map('n', '<Leader>o', '<Cmd>Telescope lsp_document_symbols<CR>', opts)
map('n', '<Leader>O', '<Cmd>Telescope lsp_workspace_symbols<CR>', opts)

-- comment.nvim
require('comment').setup {
  pre_hook = function(ctx)
    local U = require 'Comment.utils'
    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end
    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    }
  end,
}

-- lualine.nvim
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = {},
    section_separators = {},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diagnostics' },
    lualine_c = { '%F' },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { '%F' },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
}

-- TODO: formatexpr, foldexpr for lsp servers
-- TODO: for null-ls create buflocal format command to call for each
-- TODO: custom lualine setup: no diff, absolute path, no icons, no EOL, shorter mode display
-- TODO: Gitsigns and setup codeactions with it too using null-ls?
-- TODO: lazy load some packer stuff like Fugitive
