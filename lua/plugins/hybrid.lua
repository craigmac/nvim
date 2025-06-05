-- https://github.com/HoNamDuong/hybrid.nvim
-- ~/.local/share/nvim/lazy/hybrid.nvim/
---@module "lazy"
---@type LazyPluginSpec
return {
  'HoNamDuong/hybrid.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('hybrid').setup({
      italics = {
        strings = false,
        emphasis = false,
        comments = false,
        folds = false,
      },
      -- default values in:
      -- ~/.local/share/nvim/lazy/hybrid.nvim/lua/hybrid/highlights.lua and
      -- ~/.local/share/nvim/lazy/hybrid.nvim/lua/hybrid/colors.lua
      overrides = function(highlights, colors)
        highlights['@markup.raw.block'] = { bg = colors.none }
        highlights['@markup.raw'] = { bg = colors.none }
        highlights['DiagnosticVirtualTextError'] = { bg = colors.none }
        highlights['DiagnosticVirtualTextWarn'] = { bg = colors.none }
        highlights['DiagnosticVirtualTextInfo'] = { bg = colors.none }
        highlights['DiagnosticVirtualTextHint'] = { bg = colors.none }
        highlights['DiagnosticVirtualTextOk']   = { bg = colors.none }
      end,
    })

    require('hybrid').load()
  end,
}
