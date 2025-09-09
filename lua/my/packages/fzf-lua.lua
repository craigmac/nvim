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

vim.api.nvim_create_autocmd('UIEnter', { command = 'FzfLua register_ui_select' })

vim.keymap.set('n', '<Leader>:', fzf.command_history)
vim.keymap.set('n', '<Leader>f', fzf.files)
vim.keymap.set('n', '<Leader>b', fzf.buffers)
vim.keymap.set('n', '<Leader>/', fzf.live_grep_native)
vim.keymap.set('n', '<Leader><F1>', fzf.helptags)
vim.keymap.set('n', '<Leader>o', fzf.oldfiles)
