-- fist install paq-nvim: https://github.com/savq/paq-nvim#installation

require('paq')({
  'andrewferrier/debugprint.nvim',
  'glacambre/firenvim',
  'ibhagwan/fzf-lua',
  'kylechui/nvim-surround',
  'lewis6991/gitsigns.nvim',
  'mrjones2014/smart-splits.nvim',
  'neovim/nvim-lspconfig',
  'romainl/vim-cool',
  'romainl/vim-qf',
  'tommcdo/vim-lion',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-repeat',
  'tpope/vim-rhubarb',
  'tpope/vim-rsi',
  'tpope/vim-unimpaired',
  'justinmk/vim-sneak'
})

-- https://github.com/ibhagwan/fzf-lua
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

vim.api.nvim_create_autocmd('UIEnter', {
  command = 'FzfLua register_ui_select',
  group = 'my.augroup'
})

vim.keymap.set('n', '<Leader>:', fzf.command_history)
vim.keymap.set('n', '<Leader>f', fzf.files)
vim.keymap.set('n', '<Leader>b', fzf.buffers)
vim.keymap.set('n', '<Leader>/', fzf.live_grep_native)
vim.keymap.set('n', '<Leader><F1>', fzf.helptags)
vim.keymap.set('n', '<Leader>o', fzf.oldfiles)

-- https://github.com/mrjones2014/smart-splits.nvim
local splits = require('smart-splits')
splits.setup()

vim.keymap.set('n', '<C-M-h>', splits.resize_left)
vim.keymap.set('n', '<C-M-j>', splits.resize_down)
vim.keymap.set('n', '<C-M-k>', splits.resize_up)
vim.keymap.set('n', '<C-M-l>', splits.resize_right)
vim.keymap.set('n', '<M-h>', splits.move_cursor_left)
vim.keymap.set('n', '<M-j>', splits.move_cursor_down)
vim.keymap.set('n', '<M-k>', splits.move_cursor_up)
vim.keymap.set('n', '<M-l>', splits.move_cursor_right)
vim.keymap.set('n', '<M-p>', splits.move_cursor_previous)

-- no configs, using as is
-- https://github.com/tpope/vim-rsi
-- https://github.com/romainl/vim-cool

-- https://github.com/tpope/vim-rhubarb
-- https://github.com/tpope/vim-unimpaired
-- https://github.com/tpope/vim-repeat
-- https://github.com/tpope/vim-dispatch


-- https://github.com/tommcdo/vim-lion
-- when aligning with gl/gL reduces spaces to minimum required
vim.g.lion_squeeze_spaces = 1

-- run `:call firenvim#install(0)` on updates and install
-- https://github.com/glacambre/firenvim
--
-- <C-n>, <C-t>, and <C-w> must be unbound to be used for firenvim instead of browser,
-- on linux firefox you can't unbind these, but you can set alternatives in the extension
-- shortcuts to send them to firenvim using a different shortcuts, I use <A-t> <A-w> and <A-n>.
vim.g.firenvim_config = {
  globalSettings = {
    alt = 'all',
    -- hide `cmdline='firenvim'` after 3 seconds in we never get message to stop displaying it
    cmdlineTimeout = 3000,
  },
  -- js pattern against full URL, 'priority' is tiebreaker (higher wins) on multiple matches
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

-- https://github.com/tpope/vim-fugitive
vim.keymap.set('n', '<Leader>gg', '<Cmd>G<CR>')
vim.keymap.set('n', '<Leader>gP', '<Cmd>G push<CR>')
vim.keymap.set('n', '<Leader>gl', '<Cmd>G log %<CR>')

-- https://github.com/kylechui/nvim-surround
require('nvim-surround').setup({})

-- https://github.com/romainl/vim-qf
-- (s)plit, (v)ertical, (t)ab, (o)pen and come back,
-- (O)pen and close loc/qf window, (p)review
vim.g.qf_mapping_ack_style = 1
vim.g.qf_disable_statusline = 1
vim.keymap.set('n', '<Leader>q', '<Plug>(qf_qf_toggle)')
vim.keymap.set('n', '<Leader>l', '<Plug>(qf_loc_toggle)')

vim.api.nvim_create_autocmd('FileType', {
  group = 'my.augroup',
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', ':.Reject<CR>', { buffer = true })
    vim.keymap.set('x', 'd', ':Reject<CR>', { buffer = true })
  end,
})

-- https://github.com/andrewferrier/debugprint.nvim
-- text object: `g?o|O`
-- variable:    `g?v|V`
-- below|above: `g?p|P`
-- surround:    `g?sp`, `g?so`
require('debugprint').setup()

-- https://github.com/lewis6991/gitsigns.nvim
local gitsigns = require('gitsigns')

gitsigns.setup({
  signs_staged_enable = false,
  signcolumn = true,
  on_attach = function(_bufnr)
    vim.keymap.set('n', 'yog', gitsigns.toggle_signs)

    vim.keymap.set('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end)

    vim.keymap.set('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end)

    -- vim.keymap.set('x', '<Leader>hs', function()
    --   gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    -- end)

    -- vim.keymap.set('x', '<Leader>hr', function()
    --   gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    -- end)

    vim.keymap.set({ 'x', 'n' }, '<Leader>hs', gitsigns.stage_hunk)
    vim.keymap.set({ 'x', 'n' }, '<Leader>hr', gitsigns.reset_hunk)
    vim.keymap.set('n', '<Leader>hS', gitsigns.stage_buffer)
    vim.keymap.set('n', '<Leader>hR', gitsigns.reset_buffer)
    vim.keymap.set('n', '<Leader>hp', gitsigns.preview_hunk)
    vim.keymap.set('n', '<Leader>hb', gitsigns.blame_line)
    vim.keymap.set('n', '<Leader>hd', gitsigns.diffthis)
    -- diff with version of file in the commit referenced by '@' aka HEAD
    vim.keymap.set('n', '<Leader>hD', function() gitsigns.diffthis('@') end)
  end,
})

-- https://github.com/justinmk/vim-sneak

-- https://github.com/justinmk/vim-divish
-- buf names are the literal dir path, so :lcd % works
-- also can use x to add/rm from local arglist, dax to empty it
-- `.` inserts `:! <path>` into cmdline and visual . will setup
-- `:Shdo {}`



-- using deprecated old way while on 0.10.4 which doesn't have
-- vim.lsp.enable(), vim.lsp.config(), LspAttach|Detach, and more yet
--
-- https://github.com/neovim/nvim-lspconfig
-- local servers = { 'lua_ls', 'bash_ls', 'clangd' }
-- for _, lsp in ipairs(servers) do
--   on_attach = require('my.lsp').on_attach,
-- end
