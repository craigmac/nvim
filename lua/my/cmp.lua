local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
  return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

-- TODO: what does this do?
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    keyword_length = 5
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    -- manually start completion
    ['<C-Space>'] = cmp.mapping.complete(),
    -- accept selection, or if none, select first when enter hit
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    -- fallback function is provided by cmp to call e.g., default case
    ["<Tab>"] = function(fallback)
      if luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = cmp.config.sources(
  {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- command line setup, / and : completions
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- setup lspconfig
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require('lspconfig')['sumneko_lua'].setup {
  capabilities = capabilities
}
require('lspconfig')['tsserver'].setup {
  capabilities = capabilities
}
require('lspconfig')['pyright'].setup {
  capabilities = capabilities
}



  -- sources = {
  --   { name = 'nvim_lsp' },
  --   { name = 'luasnip' },
  --   { name = 'buffer' },
  --   { name = "path" },
  -- },

  -- ['<CR>'] = cmp.mapping.confirm {
  --   behavior = cmp.ConfirmBehavior.Replace,
  --   select = false,
  -- },
  -- ["<Tab>"] = cmp.mapping(function(fallback)
  --   if cmp.visible() then
  --     cmp.select_next_item()
  --   elseif luasnip.expandable() then
  --     luasnip.expand()
  --   elseif luasnip.expand_or_jumpable() then
  --     luasnip.expand_or_jump()
  --   elseif check_backspace() then
  --     fallback()
  --   else
  --     fallback()
  --   end
  -- end, {
  --   "i",
  --   "s",
  -- }),
  -- ["<S-Tab>"] = cmp.mapping(function(fallback)
  --   if cmp.visible() then
  --     cmp.select_prev_item()
  --   elseif luasnip.jumpable(-1) then
  --     luasnip.jump(-1)
  --   else
  --     fallback()
  --   end
  -- end, {
  --   "i",
  --   "s",
  -- }),
-- },
