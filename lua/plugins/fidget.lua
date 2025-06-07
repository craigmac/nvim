-- https://github.com/j-hui/fidget.nvim
-- ~/.local/share/nvim/lazy/fidget.nvim/
-- Popup notifications for e.g., LSP progress messages.
---@type LazyPluginSpec
return {
  'j-hui/fidget.nvim',
  opts = {
    notification = {
      window = {
        winblend = 0, -- don't blend
        border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
        border_hl = 'FloatBorder' -- default
      }
    }
  }
}
