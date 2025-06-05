-- https://github.com/L3MON4D3/LuaSnip
-- ~/.local/share/nvim/lazy/LuaSnip/
---@module 'lazy'
---@type LazyPluginSpec
return {
  'L3MON4D3/LuaSnip',
  version = '2.*',
  lazy = true,
  build = 'make install_jsregexp',
  config = function()
    local ls = require('luasnip')

    vim.keymap.set({ 'i' }, '<Tab>', function()
      ls.expand()
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<Tab>', function()
      ls.jump(1)
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
      ls.jump(-1)
    end, { silent = true })

    vim.keymap.set({ 'i', 's' }, '<C-e>', function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })
  end,
}
