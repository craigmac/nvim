-- https://github.com/j-hui/fidget.nvim
-- ~/.local/share/nvim/lazy/fidget.nvim/
-- Popup notifications for e.g., LSP progress messages.
---@module 'lazy'
---@type LazyPluginSpec
return {
  'j-hui/fidget.nvim',
  opts = {
    progress = {
      display = {
        -- default 'Constant' is orange in hybrid so choosing one that is usually green/greenish
        done_style = 'DiagnosticOk'
      }
    },
    notification = {
      -- use fidget for vim.notify calls
      override_vim_notify = true,
      window = {
        normal_hl = 'NormalFloat', -- default is 'Comment'
        border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
        winblend = 0, -- default is 100, docs suggest <100 if using border chars
        zindex = 60, -- default is 45, default for vim windows is 50
      }
    }
  },
}
