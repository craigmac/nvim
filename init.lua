-- vi: et tw=120 sw=2 sts=-1 fdm=marker
-- nvim debian stable config (0.10.4)

require('my.globals')
require('my.options')

-- Autocommands / FileTypes {{{1
local myaugroup = vim.api.nvim_create_augroup('my.augroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = myaugroup,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'fugitiveblame',
  callback = function()
    vim.cmd.normal('A')
    vim.wo.statusline = ' '
  end,
  group = myaugroup,
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufLeave', 'InsertEnter', 'InsertLeave' }, {
  command = 'set cursorline!',
  group = myaugroup,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local ln = vim.fn.line('\'"')
    local lastln = vim.fn.line('$')
    if ln > 1 and ln <= lastln then vim.cmd.normal({ 'g`"', bang = true }) end
  end,
  group = myaugroup,
})

vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan or 0).client
    if client ~= nil and client.name == 'Firenvim' then
      vim.o.laststatus = 0
      vim.o.showtabline = 0
      vim.o.winbar = ''
      vim.o.background = 'light'
      vim.cmd.colorscheme('default')
      vim.o.spell = true
      vim.cmd.startinsert()
    end
  end,
})

-- mark OSC 133 locations in `:terminal` prompts with `sign_text`
local ns = vim.api.nvim_create_namespace('my.terminal.prompt')
vim.api.nvim_create_autocmd('TermRequest', {
  callback = function(ev)
    if string.match(vim.v.termresponse, '^\027]133;A') then
      local lnum = ev.data.cursor[1]
      vim.api.nvim_buf_set_extmark(ev.buf, ns, lnum - 1, 0, {
        sign_text = '$',
        sign_hl_group = 'SpecialChar',
      })
    end
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = myaugroup,
  callback = function(args)
      vim.api.nvim_set_option_value('number', false, {})
      vim.cmd.startinsert()
  end
})

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  group = myaugroup,
  callback = function(args)
    if vim.api.nvim_get_option_value('buftype', { buf = args.buf }) == 'terminal' then
      vim.cmd.startinsert()
    end
  end
})

-- Keymaps {{{1
vim.keymap.set('n', '<Leader>w', '<Cmd>silent update ++p<CR>')
vim.keymap.set('n', '<Leader><CR>', '<Cmd>source %<CR>')
vim.keymap.set('n', '<Leader><Space>', '<Cmd>b #<CR>')
vim.keymap.set('n', '<Leader>,', ':<C-u>silent tabedit $MYVIMRC <Bar> :tcd %:h<CR>', { silent = true })
vim.keymap.set('n', "'", '`')
vim.keymap.set('n', 'zS', '<Cmd>Inspect<CR>')
vim.keymap.set('n', 'g:', ':<C-u>lua =')
vim.keymap.set('n', 'gV', ':<C-u>normal! `[v`]<CR>')
vim.keymap.set('n', 'n', ":<C-u>normal! <C-r>='Nn'[v:searchforward]<CR><CR>")
vim.keymap.set('n', 'N', ":<C-u>normal! <C-r>='nN'[v:searchforward]<CR><CR>")
vim.keymap.set('n', 'j', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj' end, { expr = true })
vim.keymap.set('n', 'k', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk' end, { expr = true })
vim.keymap.set('n', '<Leader>vr', ':<C-u>silent tabedit $VIMRUNTIME | tcd $VIMRUNTIME<CR>')
vim.keymap.set('n', '<Leader>vp', ':tabe <C-r>=stdpath("data").."/site/pack"<CR> | tcd <C-r>=stdpath("data")<CR><CR>')
vim.keymap.set('n', '<leader>tt', function() My.ToggleBotrightTerminal() end)

vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+Y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', "\"+pv'[']")
vim.keymap.set({ 'n', 'x' }, '<Leader>P', "\"+Pv'[']")

vim.keymap.set('i', '<C-r>', '<C-r><C-r>')
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')

vim.keymap.set('x', '.', ':normal! .<CR>')

vim.keymap.set('c', '<C-p>', function() return vim.fn.pumvisible() >= 1 and '<C-p>' or '<Up>' end, { expr = true })
vim.keymap.set('c', '<C-n>', function() return vim.fn.pumvisible() >= 1 and '<C-n>' or '<Down>' end, { expr = true })

vim.keymap.set('n', '<Leader>e', function()
  if vim.g.loaded_netrw then
    -- avoids error if the window was not previously a netrw window
    if vim.w.netrw_rexlocal == 1 then
      return ':Rex<CR>'
    else
      return ':Ex .<CR>'
    end
  end
  -- :Rex is undefined until netrw fully loaded, use `:Ex` which is always defined
  return ':Ex .<CR>'
end, { expr = true, silent = true })

-- Ex Commands {{{1
local command = function(l, r, o) vim.api.nvim_create_user_command(l, r, o or {}) end
command('Cd', 'tcd %:h')
command('Todo', 'grep TODO | copen')

-- Packages {{{1
--[[ fist install paq-nvim:
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
  'willothy/flatten.nvim'
})

vim.g.lion_squeeze_spaces = 1
vim.g.qf_mapping_ack_style = 1
vim.g.qf_disable_statusline = 1
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

vim.keymap.set('n', '<Leader>q', '<Plug>(qf_qf_toggle)')
vim.keymap.set('n', '<Leader>l', '<Plug>(qf_loc_toggle)')

require('flatten').setup({
  window = { open = 'alternate' }
})

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

    vim.keymap.set({ 'x', 'n' }, '<Leader>hs', gitsigns.stage_hunk)
    vim.keymap.set({ 'x', 'n' }, '<Leader>hr', gitsigns.reset_hunk)
    vim.keymap.set('n', '<Leader>hS', gitsigns.stage_buffer)
    vim.keymap.set('n', '<Leader>hR', gitsigns.reset_buffer)
    vim.keymap.set('n', '<Leader>hp', gitsigns.preview_hunk)
    vim.keymap.set('n', '<Leader>hb', gitsigns.blame_line)
    vim.keymap.set('n', '<Leader>hd', gitsigns.diffthis)
  end,
})

vim.api.nvim_create_autocmd('UIEnter', {
  command = 'FzfLua register_ui_select',
  group = 'my.augroup'
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'my.augroup',
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', ':.Reject<CR>', { buffer = true })
    vim.keymap.set('x', 'd', ':Reject<CR>', { buffer = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = 'my.augroup',
  pattern = 'fugitive',
  callback = function()
    -- on open jump to unstaged section
    vim.cmd([[norm gU]])
  end,
})

-- vim.lsp.enable|config(), LspAttach|Detach unavailable until nvim 0.11
-- local servers = { 'lua_ls', 'bash_ls', 'clangd' }
-- for _, lsp in ipairs(servers) do
--   on_attach = require('my.lsp').on_attach,
-- end

-- colors {{{1
vim.cmd([[
  " default link to Statement is just bold and hard to spot diff line markers quickly,
  " instead make them cyan like lazygit does
  hi! diffLine guifg=cyan
  hi! TermCursor gui=none guibg=lightgreen guifg=white
]])
