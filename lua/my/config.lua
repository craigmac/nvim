-- luasnip
local luasnip = require "luasnip"

-- nvim-cmp
local cmp = require "cmp"
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
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-u>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<C-j"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    -- I never use digraphs anyway, so repurpose the key
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
}

-- tell setup() to pass along to server what our cmp plugin can do
-- so server knows we can do things like snippets and auto imports with cmp
local my_capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Draw floating windows with double borders
local my_handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" }),
}

-- nvim-lspconfig [https://github.com/neovim/nvim-lspconfig]
--
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
  handlers = my_handlers,
  capabilities = my_capabilities,
}

-- vim-ls server (npm install -g vim-language-server)
require("lspconfig").vimls.setup {
  init_options = {
    isNeovim = true,
  },
  on_attach = my_on_attach,
  handlers = my_handlers,
  capabilities = my_capabilities,
}

-- pyright setup
require("lspconfig").pyright.setup {
  on_attach = my_on_attach,
  handlers = my_handlers,
  capabilities = my_capabilities,
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
    require "my/null_ls/markdownlint_cli2",
  },
  on_attach = my_on_attach,
  handlers = my_handlers,
  capabilities = my_capabilities,
}

require "my/gitsigns-config"
require "my/telescope-config"
require "my/diagnostics-config"
require "my/lualine-config"
require "my/treesitter-config"
-- require "my/luasnip-config"

-- TODO: gitsigns
-- TODO: lua-snip setup
-- TODO: refactor out into more maintainable chunks
