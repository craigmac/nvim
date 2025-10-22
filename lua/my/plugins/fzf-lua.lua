return {
  'ibhagwan/fzf-lua',
  cond = (not vim.g.vscode) and (not vim.g.firenvim),
  config = function()
    require('fzf-lua').setup({
      defaults = {
        file_icons = false,
      },
      -- if true, generate fzf colorscheme from current colorscheme
      fzf_colors = true,
      keymap = {
        builtin = {
          true, -- inherit defaults, false removes all except maps defined here
          ['<M-p>'] = 'toggle-preview',
          ['<C-d>'] = 'preview-page-down',
          ['<C-u>'] = 'preview-page-up',
        },
      },
      winopts = {
        fullscreen = true,
      },
    })

    vim.keymap.set('n', '<Leader>:', '<Cmd>FzfLua command_history<CR>')
    vim.keymap.set('n', '<Leader>f', '<Cmd>FzfLua files<CR>')
    vim.keymap.set('n', '<Leader>b', '<Cmd>FzfLua buffers<CR>')
    vim.keymap.set('n', '<Leader>/', '<Cmd>FzfLua live_grep_native<CR>')
    vim.keymap.set('n', '<Leader>F', '<Cmd>FzfLua<CR>')
    vim.keymap.set('n', '<Leader>.', '<Cmd>FzfLua resume<CR>')
    vim.keymap.set('n', '<Leader>o', '<Cmd>FzfLua oldfiles<CR>')
    vim.keymap.set('n', '<Leader><F1>', '<Cmd>FzfLua help_tags<CR>')
    vim.keymap.set('n', '<C-p>', '<Cmd>FzfLua global<CR>')

    -- TODO: does this work or just call it now?
    vim.api.nvim_create_autocmd('UIEnter', { command = 'FzfLua register_ui_select' })
  end,
  -- define actual keymaps in config(), after calling setup(), so fzf settings like 'winopts' apply
  keys = {
    '<Leader>:',
    '<Leader>f',
    '<Leader>b',
    '<Leader>/',
    '<Leader>F',
    '<Leader>.',
    '<Leader>o',
    '<Leader><F1>',
    '<C-p>'
  },
}
