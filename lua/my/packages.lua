--[[
git clone --depth=1 --branch=debian https://github.com/savq/paq-nvim.git \
"${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
--]]

require('paq')({
  'andrewferrier/debugprint.nvim',
  'glacambre/firenvim',
  'ibhagwan/fzf-lua',
  'kylechui/nvim-surround',
  'lewis6991/gitsigns.nvim',
  'mrjones2014/smart-splits.nvim',
  'neovim/nvim-lspconfig',
  'romainl/vim-qf',
  'tommcdo/vim-lion',
  'tpope/vim-repeat',
  'tpope/vim-rsi',
  'tpope/vim-unimpaired',
  'justinmk/vim-sneak',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'catgoose/nvim-colorizer.lua'
})

vim.g.lion_squeeze_spaces = 1

vim.g['sneak#label'] = 1

vim.g.firenvim_config = {
  globalSettings = {
    alt = 'all',
    cmdlineTimeout = 3000,
  },
  -- keys are JS-regex pattern against full URL, `priority` is tiebreaker on multiple matches
  localSettings = {
    ['.*'] = {
      -- defaults for when there's no narrower pattern match against the URL
      cmdline = 'firenvim',
      content = 'text',
      priority = 0,
      -- https://github.com/glacambre/firenvim#configuring-what-elements-firenvim-should-appear-on
      selector = 'textarea:not([readonly], [aria-readonly]), div[role="textbox"]',
      takeover = 'never',
    },
    ['https?://github.com/.*'] = {
      content = 'markdown',
      priority = 1,
      takeover = 'never',
    },
  },
}

require('debugprint').setup()
require('nvim-surround').setup({})
require('smart-splits').setup()

require('fzf-lua').setup({
  defaults = { file_icons = false },
  fzf_colors = true,
  keymap = {
    builtin = {
      true,
      ['<M-p>'] = 'toggle-preview',
      ['<C-d>'] = 'preview-page-down',
      ['<C-u>'] = 'preview-page-up',
    },
  },
  winopts = { fullscreen = true },
})
vim.api.nvim_create_autocmd('UIEnter', { command = 'FzfLua register_ui_select', group = 'my.augroup' })

vim.keymap.set('n', '<Leader>:', function() require('fzf-lua').command_history() end)
vim.keymap.set('n', '<Leader>f', function() require('fzf-lua').files() end)
vim.keymap.set('n', '<Leader>b', function() require('fzf-lua').buffers() end)
vim.keymap.set('n', '<Leader>/', function() require('fzf-lua').live_grep_native() end)
vim.keymap.set('n', '<Leader><F1>', function() require('fzf-lua').helptags() end)
vim.keymap.set('n', '<Leader>o', function() require('fzf-lua').oldfiles() end)

vim.keymap.set({ 't', 'n' }, '<M-H>', function() require('smart-splits').resize_left() end)
vim.keymap.set({ 't', 'n' }, '<M-J>', function() require('smart-splits').resize_down() end)
vim.keymap.set({ 't', 'n' }, '<M-K>', function() require('smart-splits').resize_up() end)
vim.keymap.set({ 't', 'n' }, '<M-L>', function() require('smart-splits').resize_right() end)
vim.keymap.set({ 't', 'n' }, '<M-h>', function() require('smart-splits').move_cursor_left() end)
vim.keymap.set({ 't', 'n' }, '<M-j>', function() require('smart-splits').move_cursor_down() end)
vim.keymap.set({ 't', 'n' }, '<M-k>', function() require('smart-splits').move_cursor_up() end)
vim.keymap.set({ 't', 'n' }, '<M-l>', function() require('smart-splits').move_cursor_right() end)
vim.keymap.set({ 't', 'n' }, '<M-p>', function() require('smart-splits').move_cursor_previous() end)

local gitsigns = require('gitsigns')
gitsigns.setup({
  signs_staged_enable = false,
  signcolumn = true,
  on_attach = function(_bufnr)
    vim.keymap.set('n', 'yog', gitsigns.toggle_signs)

    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gitsigns.nav_hunk('next') end
    end)

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gitsigns.nav_hunk('prev') end
    end)

    vim.keymap.set({ 'x', 'n' }, '<Leader>hs', gitsigns.stage_hunk)
    vim.keymap.set({ 'x', 'n' }, '<Leader>hr', gitsigns.reset_hunk)
    vim.keymap.set('n', '<Leader>hS', gitsigns.stage_buffer)
    vim.keymap.set('n', '<Leader>hR', gitsigns.reset_buffer)
    vim.keymap.set('n', '<Leader>hp', gitsigns.preview_hunk)
    vim.keymap.set('n', '<Leader>hb', gitsigns.blame_line)
    vim.keymap.set('n', '<Leader>hd', gitsigns.diffthis)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'my.augroup',
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', ':.Reject<CR>', { buffer = true })
    vim.keymap.set('x', 'd', ':Reject<CR>', { buffer = true })
  end,
})

vim.g.qf_mapping_ack_style = 1
vim.g.qf_disable_statusline = 1

vim.keymap.set('n', '<Leader>q', '<Plug>(qf_qf_toggle)')
vim.keymap.set('n', '<Leader>l', '<Plug>(qf_loc_toggle)')

