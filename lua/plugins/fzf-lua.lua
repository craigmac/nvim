-- https://github.com/ibhagwan/fzf-lua
---@type LazySpec
return {
  'ibhagwan/fzf-lua',
  keys = {
    { '<Leader>:', '<Cmd>FzfLua command_history<CR>' },
    { '<Leader>f', '<Cmd>FzfLua files previewer=false<CR>' },
    { '<Leader>b', '<Cmd>FzfLua buffers<CR>' },
    {
      '<Leader>/',
      function()
        require('fzf-lua').live_grep_native()
      end,
    },
    {
      '<Leader><F1>',
      function()
        require('fzf-lua').helptags()
      end,
    },
    {
      '<Leader>o',
      function()
        require('fzf-lua').oldfiles()
      end,
    },
  },
  opts = {
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
  },
  config = function()
    vim.cmd([[FzfLua register_ui_select]])
  end,
}
