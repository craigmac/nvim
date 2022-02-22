-- craigmac Neovim HEAD config

require("my.globals")

-- Options {{{
vim.g.mapleader = " "
vim.opt.breakindent = true
vim.opt.clipboard = { "unnamed", "unnamedplus" }
vim.opt.complete:remove { "d", "i" }
vim.opt.completeopt = { "menuone" }
vim.opt.diffopt = { "internal", "filler", "closeoff", "algorithm:patience" }
vim.opt.exrc = true
vim.opt.foldlevelstart = 99
vim.opt.grepprg = "grep -Hnri"
vim.opt.ignorecase = true
vim.opt.iskeyword:append { "-" }
vim.opt.listchars = { lead = "·", trail = "█", tab = "| ", eol = "" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.path:remove { "/usr/include" }
vim.opt.path:append { "**" }
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.secure = false
vim.opt.shortmess:remove { "c", "S" }
vim.opt.showmatch = true
-- TODO: make a K for lua that tries ":h on <cword>"
vim.opt.signcolumn = "number"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
-- TODO: how would you do this?
-- set tabline=%!utils#MyTabLine()
vim.opt.termguicolors = true
-- default is : "filename [+=-] (path) - NVIM"
vim.opt.title = true
-- vim.opt.titlestring = vim.fn.getcwd()
vim.opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
vim.opt.updatetime = 250
vim.opt.wrap = false

vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.cmd "packadd! cfilter"
-- }}}

-- Packer {{{
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- :PackerCompile on write to create compiled quicker loading version
vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

-- :PackerSync to update, install, and create compiled file
local use = require("packer").use
require("packer").startup(function()
  use "wbthomason/packer.nvim"

  -- Editing
  use "tpope/vim-surround"
  use "tpope/vim-commentary"
  use "tpope/vim-repeat"
  use "preservim/tagbar"

  -- Telescope and related
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "nvim-telescope/telescope-github.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use { "nvim-telescope/telescope-smart-history.nvim", requires = "tami5/sqlite.lua" }

  -- UI
  use "nvim-lualine/lualine.nvim"
  use "projekt0n/github-nvim-theme"
  -- TODO: remove this, is makes it a pain to work with listchars and figure out what things ACTUALLY are...
  -- use "lukas-reineke/indent-blankline.nvim"

  -- Treesitter and related
  use "nvim-treesitter/nvim-treesitter"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- LSP and related
  use "neovim/nvim-lspconfig"
  use "jose-elias-alvarez/null-ls.nvim"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"

  -- Git
  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"
  use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }

	-- mine
	use "/Users/cmaceach/git/nvim-stackmap"
end)
-- }}}

-- Diagnostics {{{

vim.diagnostic.config {
  virtual_text = false,
  underline = true,
  signs = false,
  float = {
    scope = "cursor",
    source = false,
    header = "",
    border = "double",
  },
}

-- }}}

-- nvim-cmp {{{
local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  completion = {
    autocomplete = false,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = false },
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
}
-- }}}

-- LSP common setup functions {{{
local my_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local my_handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" }),
}
local my_on_attach = function(_)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
  vim.keymap.set({ "i", "n" }, "<A-k>", vim.lsp.buf.signature_help, { buffer = 0 })
  vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set("n", "g.", "<cmd>Telescope lsp_code_actions<CR>", { buffer = 0 })
  vim.keymap.set("n", "gO", "<cmd>Telescope lsp_document_symbols<CR>", { buffer = 0 })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = 0 })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = 0 })
  vim.keymap.set("n", "gq", vim.lsp.buf.formatting, { buffer = 0 })
  vim.keymap.set("n", "<F4>", vim.diagnostic.setloclist, { buffer = 0 })
end
-- }}}

-- Treesitter {{{

require("nvim-treesitter.configs").setup {
  context_commentstring = { enable = true },
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "ss",
      node_incremental = "sn",
      scope_incremental = "sc",
      node_decremental = "sp",
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
}

-- }}}

-- Specific Servers {{{

-- Clangd {{{
require("lspconfig").clangd.setup {
  -- provides :ClangdSwitchSourceHeader command too
  on_attach = my_on_attach,
  handlers = my_handlers,
  capabilities = my_capabilities,
}
-- }}}

-- TODO: rebuild sumneko with newer version, keeps throwing LSP errors!
-- Lua language server (sumneko) {{{
-- local sumneko_root_path = "/Users/cmaceach/git/lsp-servers/lua-language-server"
-- local sumneko_binary = sumneko_root_path .. "/bin/" .. "/lua-language-server"
-- require("lspconfig").sumneko_lua.setup {
--   cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--         path = vim.split(package.path, ";"),
--       },
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         -- make server aware of Neovim runtime files
--         library = {
--           [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--           [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
--         },
--       },
--     },
--   },
--   on_attach = my_on_attach,
--   handlers = my_handlers,
--   capabilities = my_capabilities,
-- }
-- }}}

-- vim-ls (npm install -g vim-language-server) {{{
require("lspconfig").vimls.setup {
  init_options = {
    isNeovim = true,
  },
  on_attach = my_on_attach,
  handlers = my_handlers,
  capabilities = my_capabilities,
}
-- }}}

-- null-ls {{{
require("null-ls").setup {
  debug = false,
  sources = {
    -- For Lua, sumneko-lua server doesn't support formatting
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.prettier.with {
      disabled_filetypes = { "markdown" },
    },
    require("null-ls").builtins.diagnostics.vint,
    require("null-ls").builtins.diagnostics.yamllint,

    -- writing
    require("null-ls").builtins.diagnostics.vale,
    require("null-ls").builtins.diagnostics.cspell.with {
      filetypes = { "markdown", "text", "gitcommit", "asciidoc" },
    },
    -- custom creating by me
    require "my/null_ls/markdownlint_cli2",
  },
  on_attach = my_on_attach,
  handlers = my_handlers,
  capabilities = my_capabilities,
}
-- }}}

-- }}}

-- null-ls {{{
require("null-ls").setup {
  debug = false,
  sources = {
    -- For Lua, sumneko-lua server doesn't support formatting
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.prettier.with {
      disabled_filetypes = { "markdown" },
    },
    require("null-ls").builtins.diagnostics.vint,
    require("null-ls").builtins.diagnostics.yamllint,

    -- writing
    require("null-ls").builtins.diagnostics.vale,
    require("null-ls").builtins.diagnostics.cspell.with {
      filetypes = { "markdown", "text", "gitcommit", "asciidoc" },
    },
    -- custom creating by me
    require "my/null_ls/markdownlint_cli2",
  },
  on_attach = my_on_attach,
  handlers = my_handlers,
  capabilities = my_capabilities,
}
-- }}}

-- vim-fugitive {{{
-- Status and quick one-off :G commands
vim.keymap.set("n", "<Leader>gg", "<Cmd>G<CR>")
vim.keymap.set("n", "<Leader>g<Space>", ":G<Space>")
-- Add <cfile> to index and save, gW useful in 3 way merge diffs: choose
-- a buffer and use gW to use all that versions' changes, i.e., --ours/theirs
vim.keymap.set("n", "<Leader>gw", "<Cmd>Gwrite<CR>")
vim.keymap.set("n", "<Leader>gW", "<Cmd>Gwrite!<CR>")

-- Blames
vim.keymap.set("n", "<Leader>gb", "<cmd>G blame<CR>")

-- Location list no jump log of current file and general commit log
vim.keymap.set("n", "<Leader>gl", "<cmd>0Git log<CR>")
vim.keymap.set("n", "<Leader>gL", "<cmd>Git log<CR>")

-- :Gedit is 'git checkout %' => reverts work tree file to index, be careful!
vim.keymap.set("n", "<Leader>ge", ":Gedit<Space>")
vim.keymap.set("n", "<Leader>gE", ":Gedit <bar> only<CR>")

-- Add all and start commit message with --verbose flag to show patches
vim.keymap.set("n", "<Leader>gc", "<cmd>G commit -av<CR>")

-- Vertical diffs on current file or any git object SHA.
-- :h fugitive-object helpers: @ aka HEAD, :% index version of <cfile>
vim.keymap.set("n", "<Leader>gd", "<cmd>Gvdiffsplit<CR>")
vim.keymap.set("n", "<Leader>gD", ":Gvdiffsplit<space>")

-- Grepping git trees and commits messages. '!' to run it async.
-- git grep 'foo bar' [branch/SHA]
-- git log --grep='foobar' to search commit messages
-- git log -Sfoobar (when 'foobar' was added/removed)
vim.keymap.set("n", "<Leader>g/", ":Ggrep! -Hnri --quiet<Space>")
vim.keymap.set("n", "<Leader>g?", ":Git! log --grep=")
vim.keymap.set("n", "<Leader>gS", ":Git! log -S")
vim.keymap.set("n", "<Leader>g*", ':Ggrep! -Hnri --quiet <C-r>=expand("<cword>")<CR><CR>')

-- git push/pull/fetching
vim.keymap.set("n", "<Leader>gP", "<cmd>G push<CR>")
vim.keymap.set("n", "<Leader>gp", "<cmd>G pull<CR>")
vim.keymap.set("n", "<Leader>gf", "<cmd>G fetch<CR>")

-- Requires vim-rhubarb, visual selection appends anchors to URL to highlight
-- Reminder: ["register]y<C-g> to yank relative path to clipboard
-- Reminder: :GBrowse! doesn't open URL just yanks it to clipboard
vim.keymap.set("n", "<Leader>g@", "<cmd>GBrowse<CR>")
vim.keymap.set("x", "<Leader>g@", "<cmd>GBrowse<CR>")
-- }}}

-- telescope.nvim {{{
require("telescope").setup {
  defaults = {
    history = {
      path = vim.fn.stdpath "data" .. "/databases/telescope_history.sqlite3",
      limit = 100,
    },
    -- horizontal when wide enough, otherwise stacked panels
    layout_strategy = "flex",
    layout_config = {
      bottom_pane = {
        height = 10,
        preview_cutoff = 120,
        prompt_position = "bottom"
      },
      center = {
        height = 0.4,
        preview_cutoff = 40,
        prompt_position = "top",
        width = 0.5,
        anchor = "N",
      },
      cursor = {
        height = 0.9,
        preview_cutoff = 40,
        width = 0.8
      },
      horizontal = {
        height = 0.9,
        preview_cutoff = 120,
        prompt_position = "top",
        width = 0.8,
      },
      vertical = {
        height = 0.9,
        preview_cutoff = 40,
        prompt_position = "top",
        width = 0.8
      }
    },
    mappings = {
      -- TODO map <C-w>r to cycle_layout_list to cycle between
      -- "horizontal" and "vertical" layout strategies
      i = {
        ["<C-o>"] = require("telescope.actions.layout").toggle_preview,
        ["<C-Down>"] = "cycle_history_next",
        ["<C-Up>"] = "cycle_history_prev",
      },
    },
    -- TODO: someday try again, this was bugging out on devx w/ "macos.md$"
    -- path_display = { "smart" },
    path_display = { "absolute" },
    preview = {
      hide_on_startup = true, -- toggle with my C-o binding
    },
    prompt_prefix = " ",
    selection_caret = "  ",

    -- IDEA: more ornate borders using utf.
    -- borderchars = { "-", "|", "-", "|", "-", "|", "-", "|"}

    -- IDEA: can this be put on left-hand side instead?
    -- get_status_text = function(picker) return "Search files by name" end,
  },
  pickers = {
		-- global defaults are in setup.layout_config table above
		git_files = {
		},
    spell_suggest = {
      theme = "cursor",
    },
    lsp_code_actions = {
      theme = "cursor",
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
  },
}

-- these need to come after main setup() call
require("telescope").load_extension "fzf"
require("telescope").load_extension "ui-select"
require("telescope").load_extension "gh"
-- context sensitive history (cwd + picker using)
require("telescope").load_extension "smart_history"

-- specific picker overrides in require("telescope")setup.pickers table
vim.keymap.set("n", "<Leader><Leader>", require("telescope.builtin").git_files)
vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<Leader><Tab>", require("telescope.builtin").buffers)
vim.keymap.set("n", "<Leader><C-]>", require("telescope.builtin").tags)
vim.keymap.set("n", "<Leader>:", require("telescope.builtin").commands)
vim.keymap.set("n", "z=", require("telescope.builtin").spell_suggest)
vim.keymap.set("n", '<Leader>"', require("telescope.builtin").registers)
vim.keymap.set("n", "<Leader>t", "<cmd>Telescope<CR>")
vim.keymap.set("n", "<Leader>hf", require("telescope").extensions.gh.pull_request_files)
vim.keymap.set("n", "<Leader>hp", require("telescope").extensions.gh.pull_request)
vim.keymap.set("n", "<Leader>hi", require("telescope").extensions.gh.issues)
vim.keymap.set("n", "<Leader>hg", require("telescope").extensions.gh.gist)
-- }}}

-- lualine {{{
-- TODO: add truncation of parts for <81 chars width:
-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#truncating-components-in-smaller-window
require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "github",
    always_divide_middle = true,
  },
  sections = {
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
}
-- }}}

-- luasnips {{{
local ls = require "luasnip"
ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

-- For several choice nodes, this cycles through them
vim.keymap.set("i", "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

ls.snippets = {
  all = {
    -- Available in all ft
  },
  lua = {
    ls.parser.parse_snippet("lua-local-function", "local $1 = function($2)\n	$3\nend\n\n$0"),
    ls.parser.parse_snippet("lua-module-function", "M.$1 = function(opts)\n	opts = opts or {}\n	$2\nend\n\n$0"),
		ls.parser.parse_snippet("lua-setup-M", "local M = {}\n\n$1\n\nreturn M\n")
  },
  markdown = {
    ls.parser.parse_snippet("wm-danger", "{% alert_box danger %}\n$1\n{% endalert_box %}\n$0"),
    ls.parser.parse_snippet("wm-important", "{% alert_box important %}\n$1\n{% endalert_box %}\n$0"),
    ls.parser.parse_snippet("wm-note", "{% alert_box note %}\n$1\n{% endalert_box %}\n$0"),
    ls.parser.parse_snippet("wm-warning", "{% alert_box warning %}\n$1\n{% endalert_box %}\n$0"),
    ls.parser.parse_snippet("wm-tip", "{% alert_box tip %}\n$1\n{% endalert_box %}\n$0"),

    ls.parser.parse_snippet("wm-image", "[$1]({{ site.baseurl}}{{ page.images_folder}}/$2)$0"),
    ls.parser.parse_snippet("wm-figure", "{% include figure src=\"$1\" alt=\"$2\" width=\"$3\" align=\"left\" class=\"img-fluid\" caption=\"$4\" %} $0"),
		ls.parser.parse_snippet("wm-snippet", "{% include {{ page.version }}/snippets/$1.md %} $0"),
		ls.parser.parse_snippet("wm-pageversion", "{{ page.version }}$0"),
		ls.parser.parse_snippet("wm-relativelink", "[$1](../$2/) $0"),
		ls.parser.parse_snippet("wm-externallink", "[$1](https://$2) $0"),
		ls.parser.parse_snippet("wm-link", "[$1](/{{ page.version }}/$2/) $0"),
		ls.parser.parse_snippet("wm-newpage", "---\ntitle: $1\nexcerpt: $2\ncategory: $3\nsub-category: $4\ntags: $5\n---\n$0"),
		ls.parser.parse_snippet("wm-codeblock", "{% raw %}\n\n```$1\n$2\n```\n\n{% endraw %}\n\n$0"),
	},
}

-- TODO: placeholders for the snippets
--       "title: \"${1:Set up macOS for C++ App Development}\"",
--       "excerpt: \"${2:Get started with installing Engine on macOS platform.\"}",
--       "category: ${3:cpp | rn | designer (choose just 1)}",
--       "sub_category: ${4:guides}",
--       "tags: ${5:CPP RN Designer (choose up to 3, but at least 1)}",
--       "```${1:jsx|shell|cpp|make mostly}",
-- }}}

-- Commands {{{

-- vimscript - simplest
-- command! SayHello :echo 'Hello World!'
--
-- lua
vim.api.nvim_add_user_command("SayHello", "echo 'Hello World!'", {})

-- vimscript
-- command! Api :help list-functions<CR>
--
-- lua
-- default is command! version to overwrite any existing :Api command
vim.api.nvim_add_user_command("VimscriptFunctions", "help list-functions", {})

-- vimscript
-- command! Cd :lcd %:h
--
-- lua: dynamic construction of RHS, without using any passed in arguments. '_' is convention
-- to say we aren't going to use this parameter but the signature requires it.
vim.api.nvim_add_user_command("Cd", function(_) return "lcd " .. vim.fn.expand("%:h") end, {})

-- The table passed to the second parameter, "command" if it's a function:
--{
--	args: (string), vimscript <args>
--	bang: (boolean), vimscript modified <bang>
--	line1: (number), vimscript <line1>
--	line2: (number), vimscript <line2> 
--	range: (number), vimscript <range>
--	count: (number), vimscript <count>
--	reg: (string), vimscript <reg>
--	mods: (string), vimscript <mods>
--}

-- vimscript
-- command! TodoLocal :botright silent! lvimgrep /\v\CTODO|FIXME|HACK|DEV/ %<CR>
--
-- lua: need to double escape backslashes
vim.api.nvim_add_user_command("TodoLocal", "botright silent! lvimgrep /\\v\\CTODO|FIXME|HACK|DEV/", {})

-- vimscript:
-- command! Todo :botright silent! vimgrep /\v\CTODO|FIXME|HACK|DEV/ *<CR>
--
-- lua:
vim.api.nvim_add_user_command("Todo", "botright silent! vimgrep /\\v\\CTODO|FIXME|HACK|DEV/ *<CR>", {})

-- vimscript
-- command! JekyllOpen call utils#JekyllOpenLive()
--
-- lua: calling an autoload function
-- The '#' is an issue because it's not valid lua, so it's a special case, if we put this in
-- a lua string it will try to expand '#' as the alternate file name.
vim.api.nvim_add_user_command("JekyllOpen", function(_) vim.fn['utils#JekyllOpenLive']() end, {}) 

-- vimscript: autoload function with requires 1 or more string arguments
-- command! -nargs=1 Redir call utils#Redir(<args>)
--
-- and in ~/.vim/autoload/utils.vim, the definition:
--
-- Executes an ex-command an captures output to a scratch buffer, such as "buffers" or "version"
-- function! utils#Redir(cmd) abort
--   let output = execute(a:cmd)
--   botright split +enew
--   setlocal nobuflisted nonumber norelativenumber buftype=nofile bufhidden=wipe noswapfile
--   nnoremap <buffer> q :bwipeout!<CR>
--   call setline(1, split(output, "\n"))
-- endfunction
-- 
-- lua: calling an autoload with required arguments, e.g. :Redir ls
-- vim.api.nvim_add_user_command("Redir", function(cmd) 
-- 	vim.pretty_print(cmd)
	-- print(cmd.args)
	-- weird, :lua vim.fn['utils#Redir']("ls") works fine...
	-- vim.fn['utils#Redir'](cmd.args) 
-- end, { nargs = 1 })

vim.api.nvim_add_user_command("Redir", "call utils#Redir(<args>)", { nargs =1 })
-- }}}

-- Keymaps {{{
-- vim.keymap.set() automatically handles the 'noremap' sensibly, if the LHS
-- has 'plug' in it, it sets remap = true in opts, otherwise false. It also handles
-- correctly translating termcodes such as <Tab> and <Leader> which are vimscript only
-- representations of characters that don't display (unless listchars is on).
--
-- 
-- vimscript:
-- inoremap <C-Space> <C-x><C-o>
--
-- lua:
vim.keymap.set('i', "<C-Space>", "<C-x><C-o>")

local silent = { silent = true }

-- Get started with:
-- :%s/^nnoremap\s\+/vim.keymap.set("n",/
vim.keymap.set("n", "<Leader><CR>", "<Cmd>source %<CR>")
vim.keymap.set("n", "<Leader>w", "<Cmd>update<CR>")
vim.keymap.set("n", "<Leader>,", "<Cmd>edit $MYVIMRC<CR>")
vim.keymap.set("n", "<Leader>ft", ":e <C-R>=expand('~/.config/nvim/after/ftplugin/'.&ft.'.vim')<CR><CR>")
vim.keymap.set("n", "<Leader>bb", "<Cmd>buffer #<CR>")
vim.keymap.set("n", "<Leader>dd", "<Cmd>bdelete!<CR>")
vim.keymap.set("n", "<C-b>s", ":split +terminal<CR>")
vim.keymap.set("n", "<C-b>v", ":vsplit +terminal<CR>")
vim.keymap.set("n", "<C-b>!", "<C-w>T")

-- vimscript:
-- nnoremap <C-b>s :split +terminal<CR>
-- nnoremap <C-b>v :vsplit +terminal<CR>
-- nnoremap <C-b>! <C-w>T
-- tnoremap <C-b>s <C-\><C-n>:split +terminal<CR>
-- tnoremap <C-b>v <C-\><C-n>:vsplit +terminal<CR>
-- tnoremap <C-b>! <C-\><C-n><C-w>T
--
-- lua: must escape backslashes in strings
vim.keymap.set("t", "<C-b>s", "<C-\\><C-n>:split +terminal<CR>")
vim.keymap.set("t", "<C-b>v", "<C-\\><C-n>:vsplit +terminal<CR>")
vim.keymap.set("t", "<C-b>!", "<C-\\><C-n><C-w>T")

-- vimscript:
-- nnoremap <silent><C-Up> <Cmd>2wincmd+<CR>
-- nnoremap <silent><C-Down> <Cmd>2wincmd-<CR>
-- nnoremap <silent><C-Left> <Cmd>2wincmd <<CR>
-- nnoremap <silent><C-Right> <Cmd>2wincmd ><CR>
--
-- lua:
vim.keymap.set("n", "<C-Up>", "<Cmd>2wincmd+<CR>", silent)
vim.keymap.set("n", "<C-Down>", "<Cmd>2wincmd-<CR>", silent)
vim.keymap.set("n", "<C-Left>", "<Cmd>2wincmd<<CR>", silent)
vim.keymap.set("n", "<C-Right>", "<Cmd>2wincmd><CR>", silent)

-- vimscript:
-- xmap < <gv
-- xmap > >gv
--
-- lua:
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- vimscript:
-- Move visual selection up/down lines.
-- xnoremap J :m '>+1<CR>gv=gv
-- xnoremap K :m '<-2<CR>gv=gv
--
-- lua:
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")


-- vimscript:
-- nnoremap <silent><F7> <cmd>15Lexplore<CR>
-- nnoremap <silent><F8> <cmd>TagbarOpenAutoClose<CR>
-- nnoremap <silent><F9> <cmd>set list!<CR>
-- nnoremap <Leader>* :grep <C-r><C-w><Space>
--
-- lua:
vim.keymap.set("n", "<F7>", "<Cmd>25Lexplore<CR>", { silent = true })
vim.keymap.set("n", "<F8>", "<Cmd>TagbarOpenAutoClose<CR>", { silent = true })
vim.keymap.set("n", "<F9>", "<Cmd>set list!<CR>")
-- note: whitespace is significant in RHS strings so technically we don't need to use
-- <Space> here we could just end with a space, but better to be explicit
vim.keymap.set("n", "<Leader>*", ":grep <C-r><C-w><Space>")

-- vimscript:
--nnoremap gh :diffget //2<CR>
--nnoremap gl :diffget //3<CR>
--nnoremap [q <cmd>cprevious<CR>
--nnoremap ]q <cmd>cnext<CR>
--nnoremap [Q <cmd>cfirst<CR>
--nnoremap ]Q <cmd>clast<CR>
--nnoremap <C-p> <cmd>lprevious<CR>
--nnoremap <C-n> <cmd>lnext<CR>
--nnoremap <M-n> <cmd>llast<CR>
--nnoremap <M-p> <cmd>lfirst<CR>
--nnoremap ]t <cmd>tabnext<CR>
--nnoremap [t <cmd>tabprev<CR>
--nnoremap [T <cmd>tabfirst<CR>
--nnoremap ]T <cmd>tablast<CR>
--
-- lua:
vim.keymap.set("n", "gh", "<Cmd>diffget //2<CR>")
vim.keymap.set("n", "gl", "<Cmd>diffget //3<CR>")
vim.keymap.set("n", "[q", "<Cmd>cprevious<CR>")
vim.keymap.set("n", "]q", "<Cmd>cnext<CR>")
vim.keymap.set("n", "[Q", "<Cmd>cfirst<CR>")
vim.keymap.set("n", "]Q", "<Cmd>clast<CR>")
vim.keymap.set("n", "<C-p>", "<Cmd>lprevious<CR>")
vim.keymap.set("n", "<C-n>", "<Cmd>lnext<CR>")
vim.keymap.set("n", "<M-n>", "<Cmd>llast<CR>")
vim.keymap.set("n", "<M-p>", "<Cmd>lfirst<CR>")
vim.keymap.set("n", "]t", "<Cmd>tabnext<CR>")
vim.keymap.set("n", "[t", "<Cmd>tabprev<CR>")
vim.keymap.set("n", "[T", "<Cmd>tabfirst<CR>")
vim.keymap.set("n", "]T", "<Cmd>tablast<CR>")

-- vimscript:
-- nnoremap g; g;zv
-- nnoremap g, g,zv
-- nnoremap <silent> } <cmd>keepjumps normal! }<CR>
-- nnoremap <silent> { <cmd>keepjumps normal! {<CR>
--
-- lua:
vim.keymap.set("n", "g;", "g;zv")
vim.keymap.set("n", "g,", "g,zv")
vim.keymap.set("n", "}", "<Cmd>keepjumps normal! }<CR>")
vim.keymap.set("n", "{", "<Cmd>keepjumps normal! {<CR>")

-- vimscript:
-- nnoremap <Leader>/ :grep<Space>
-- nnoremap <Leader>? :vimgrep //j **/*.md<S-Left><S-Left><Right>
-- nnoremap <Leader>@ <cmd>JekyllOpen<CR>
--
-- lua:
vim.keymap.set("n", "<Leader>/", ":grep<Space>")
vim.keymap.set("n", "<Leader>?", ":vimgrep //j **/*.md<S-Left><S-Left><Right>")
vim.keymap.set("n", "<Leader>@", "<Cmd>JekyllOpen<CR>")

-- vimscript:
-- tnoremap <Esc> <C-\><C-n>
-- tnoremap <C-v><Esc> <Esc>
-- tnoremap <C-w>h <C-\><C-n><C-w>h
-- tnoremap <C-w>k <C-\><C-n><C-w>k
-- tnoremap <C-w>j <C-\><C-n><C-w>j
-- tnoremap <C-w>l <C-\><C-n><C-w>l
--
-- lua: backslashes in strings need to be escaped
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-v><Esc>", "<Esc>")
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-w>k", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-w>j", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-w>l", "<C-\\><C-n><C-w>l")

-- vimscript:
-- nmap <Leader>T <Plug>PlenaryTestFile
--
-- lua: keymap.set knows we need to allow remapping on the RHS here to do the right thing
vim.keymap.set("n", "<Leader>T", "<Plug>PlenaryTestFile")

-- vimscript autoload command calls:
-- nnoremap <silent><F3> <cmd>call utils#ToggleQuickfixList()<CR>
-- nnoremap <silent><F4> <cmd>call utils#ToggleLocationList()<CR>
--
-- lua:
vim.keymap.set("n", "<F3>", vim.fn['utils#ToggleQuickfixList'])
vim.keymap.set("n", "<F4>", vim.fn['utils#ToggleLocationList'])

-- vimscript command-line setting a map using a conditional expression
-- cnoremap <expr> <C-p> wildmenumode() ? "<C-P>" : "<Up>"
-- cnoremap <expr> <C-n> wildmenumode() ? "<C-N>" : "<Down>"
--
-- lua:
-- vim.keymap.set("c", "<C-p>", "", { expr = true })
-- vim.keymap.set("c", "<C-p>", "", { expr = true })

-- vimscript
-- cnoremap <expr> <C-j> wildmenumode() ? "\<Up>\<C-z>" : "\<C-j>"
-- cnoremap <expr> <C-k> wildmenumode() ? "\<Down>\<C-z>" : "\<C-k>"
-- cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
--
-- lua: requires :h 'wildchar' to set <C-z>
vim.keymap.set("c", "<C-j>", function()
	return vim.fn.wildmenumode() == 1 and "<Up><C-z>" or "<C-j>"
end, { expr = true })

vim.keymap.set("c", "<C-k>", function()
	return vim.fn.wildmenumode() == 1 and "<Down><C-z>" or "<C-k>"
end, { expr = true })

vim.keymap.set("c", "%%", function()
	return vim.fn.getcmdtype() == ":" and vim.fn.expand("%:h") .. "/" or "%%"
end, { expr = true})
-- }}}

-- UI and Colors {{{
vim.cmd [[
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
  " Unhides @ symbols for EOF and things like EOL char in listchars
  highlight! NonText guifg=#C3C7CB
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
]]
-- }}}

--- Autocommands {{{
vim.cmd [[
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
  autocmd BufEnter $MYVIMRC setlocal fdm=marker
  autocmd BufWinEnter * if &previewwindow | setlocal nonumber norelativenumber nolist | endif
  autocmd TermOpen * startinsert | setlocal nonumber norelativenumber
  autocmd TermOpen * setlocal statusline=%{b:term_title}
  " Auto close terminal buffers if exit status was 0 (no errors)
  autocmd TermClose * if !v:event.status | execute 'bdelete! ' .. expand('<abuf>') | endif
  autocmd BufEnter term://* startinsert
  autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
  " Stop fugitive from littering buffer list
  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd FileType TelescopePrompt setlocal nocursorline
augroup END
-]]
--- }}}

-- vim: ts=2 sts=2 sw=2 noet fdm=marker
