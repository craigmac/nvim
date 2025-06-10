-- https://github.com/ibhagwan/fzf-lua
-- ~/.local/share/nvim/lazy/fzf-lua/
---@type LazyPluginSpec
return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  -- if just declaring keys, they must be defined inside config() call
  keys = { '<Leader>:', '<Leader>f', '<Leader>b', '<Leader>/', '<Leader><F1>', '<Leader>o' },
  config = function()
    local fzf = require('fzf-lua')

    fzf.setup({
      defaults = { file_icons = false },
      fzf_colors = true, -- use colors from nvim
      keymap = {
        builtin = {
          true, -- override the defaults
          ['<M-p>'] = 'toggle-preview',
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
        },
      },
      winopts = { fullscreen = true },
    })

    -- fuzzy search `q:`
    vim.keymap.set('n', '<Leader>:', fzf.command_history)

    -- (f)ind like `:find **/`
    vim.keymap.set('n', '<Leader>f', fzf.files)

    -- (b)uffers like `:buffers`
    vim.keymap.set('n', '<Leader>b', fzf.buffers)

    -- supercharged `:h /`
    vim.keymap.set('n', '<Leader>/', fzf.live_grep_native)

    -- like <F1> brings up help
    vim.keymap.set('n', '<Leader><F1>', fzf.helptags)

    -- like the 'o' in <C-o> to jump back, uses the :oldfiles list
    vim.keymap.set('n', '<Leader>o', fzf.oldfiles)

    vim.cmd([[FzfLua register_ui_select]])
  end,
}
