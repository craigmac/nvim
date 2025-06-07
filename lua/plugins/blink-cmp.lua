-- https://github.com/saghen/blink.cmp
---@type LazyPluginSpec
return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '1.*',
  -- dependencies = { 'L3MON4D3/LuaSnip' },
  opts = {
    -- `:h blink-cmp-config-keymap`
    keymap = { preset = 'super-tab' },
    -- this was causing selected pmenu icons to shrink
    -- appearance = { nerd_font_variant = 'mono' },
    completion = {
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 500
      },
    },
    sources = {
      default = { 'lsp', 'path' },
    },
    -- snippets = { preset = 'luasnip' },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
  },
}
