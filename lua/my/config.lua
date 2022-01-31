-- nvim-cmp
local cmp = require "cmp"
cmp.setup {
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
    { name = "path" },
  },
}

-- Inside foo.setup() for each language server config, we
-- pass this to 'on_attach' function to run after connected to server.
local my_on_attach = function(_)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

  vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
  vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = 0 })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = 0 })
  vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = 0 })
  vim.keymap.set("n", "g.", "<cmd>Telescope lsp_code_actions<CR>", { buffer = 0 })
  vim.keymap.set("n", "gO", "<cmd>Telescope lsp_document_symbols<CR>", { buffer = 0 })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
  vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { buffer = 0 })
  vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { buffer = 0 })
  vim.keymap.set("n", "gq", vim.lsp.buf.formatting, { buffer = 0 })
  vim.keymap.set("n", "<F4>", vim.diagnostic.setloclist, { buffer = 0 })
end

-- Lua language server (sumneko)
local sumneko_root_path = "/Users/cmaceach/git/lsp-servers/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. "/lua-language-server"
require("lspconfig").sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
      },
    },
  },
  on_attach = my_on_attach,
}

-- vim-ls server (npm install -g vim-language-server)
require("lspconfig").vimls.setup {
  init_options = {
    isNeovim = true,
  },
  on_attach = my_on_attach,
}

-- null-ls setup
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
    require "my.null_ls.markdownlint_cli2",
  },
  on_attach = my_on_attach,
}

-- telescope.nvim
local actions = require "telescope.actions"
-- local previewers = require "telescope.previewers"
-- local sorters = require "telescope.sorters"
-- local finders = require "telescope.finders"
local layouts = require "telescope.actions.layout"
-- local pickers = require "telescope.pickers"
-- local action_state = require "telescope.actions.state"
-- local conf = require("telescope.config").values
require("telescope").setup {
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
      require("telescope.themes").get_dropdown {},
    },
  },
}

-- TODO: try out nvim-telescope/telescope-github.nvim
-- these need to come after main setup() call
require("telescope").load_extension "fzf"
-- sets vim.ui.select to use telescope so things like vim.lsp.buf.code_action()
-- will use telescope interface instead
require("telescope").load_extension "ui-select"
require("telescope").load_extension "gh"

vim.keymap.set("n", "<C-p>", require("telescope.builtin").git_files)
vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<Leader><Tab>", require("telescope.builtin").buffers)
vim.keymap.set("n", "<Leader><F1>", require("telescope.builtin").help_tags)
vim.keymap.set("n", "<Leader><C-]>", require("telescope.builtin").tags)
vim.keymap.set("n", "<Leader>:", require("telescope.builtin").commands)
vim.keymap.set("n", "z=", require("telescope.builtin").spell_suggest)
vim.keymap.set("n", '<Leader>"', require("telescope.builtin").registers)

-- treesitter.nvim
require("nvim-treesitter.configs").setup {
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
}

-- vim.diagnostic settings
-- TODO: popup shown on mouse hover
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

-- lualine.nvim
-- TODO: add truncation of parts for <81 chars width:
-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#truncating-components-in-smaller-window
require("lualine").setup {
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
}
