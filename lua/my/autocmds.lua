-- autogroup naming convention:
--
-- 'my.augroup.cursorline'    group of event(s) that triggers managing the 'cursorline' option
-- 'my.augroup.winenter'      WinEnter event. a general catch all that's not limited to one subject
-- 'my.augroup.term.winenter' WinEnter event, but specifically for terminal buffers

-- subject comes before the event, i.e., 'term.winenter' not 'winenter.term', so that all terminal-related
-- autocmds are easily found under 'my.augroup.term.*'

local augroup_typ = vim.api.nvim_create_augroup('my.augroup.textyankpost', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
  desc = 'Briefly highlight yanked text',
  group = augroup_typ,
})

local augroup_cursorline = vim.api.nvim_create_augroup('my.augroup.cursorline', {})
vim.api.nvim_create_autocmd({ 'WinEnter', 'InsertLeave', 'TermLeave' }, {
  command = 'setlocal cursorline',
  desc = 'Turn on cursorline highlight.',
  group = augroup_cursorline,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'InsertEnter', 'TermEnter' }, {
  command = 'setlocal nocursorline',
  desc = 'Turn off cursorline highlight.',
  group = augroup_cursorline,
})

local augroup_last_edit_position = vim.api.nvim_create_augroup('my.augroup.last_edit', {})
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local ln = vim.fn.line('\'"')
    local lastln = vim.fn.line('$')
    if ln > 1 and ln <= lastln then vim.cmd.normal({ 'g`"', bang = true }) end
  end,
  desc = 'Goto last edit position after reading a buffer.',
  group = augroup_last_edit_position,
})

local augroup_external_ui = vim.api.nvim_create_augroup('my.augroup.external_ui', {})
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan or 0).client
    if client ~= nil and client.name == 'Firenvim' then
      vim.o.laststatus = 1
      vim.o.showtabline = 1
      vim.o.winbar = ''
      vim.o.background = 'light'
      vim.cmd.colorscheme('default')
      vim.bo.spelloptions = 'camel' -- 'ConsideredFourSeparateWords' = 4 words to check
      vim.o.spellsuggest = 'best,5' -- only show 5 suggestions
      vim.wo.spell = true
      vim.wo.foldcolumn = 0
      vim.wo.foldenable = false
      vim.wo.signcolumn = auto
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.wo.list = false
      vim.o.guifont = 'Adwaita Mono:h11,Deja Vu Sans Mono:h11,Inconsolata:h11,Monaco:h11'
      vim.cmd.startinsert()
    end
  end,
  desc = 'Ran when an UI like firenvim, vscode, even default TUI attaches to nvim',
  group =  augroup_external_ui
})

local augroup_ts_ft = vim.api.nvim_create_augroup('my.augroup.treesitter.filetype', {})
vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
  desc = 'Try starting treesitter for every filetype, ignoring if parser missing.',
  group = augroup_ts_ft,
})

local augroup_term_request = vim.api.nvim_create_augroup('my.augroup.term.request', {})
local ns = vim.api.nvim_create_namespace('my.terminal.prompt')
vim.api.nvim_create_autocmd('TermRequest', {
  callback = function(args)
    if string.match(args.data.sequence, '^\027]133;A') then
      ---@type integer
      local lnum = args.data.cursor[1]
      vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
        sign_text = '$',
        sign_hl_group = 'SpecialChar',
      })
    end
  end,
  desc = 'Annotate prompt marks if OSC 133 is emitted. Use [[ and ]] to navigate.',
  group = augroup_term_request,
})

local augroup_term_open = vim.api.nvim_create_augroup('my.augroup.term.open', {})
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.wo.signcolumn = 'auto'
    vim.cmd.startinsert()
  end,
  desc = 'When terminal job starting. Used to configure terminal buffer.',
  group = augroup_term_open,
})

local augroup_term_autoinsert = vim.api.nvim_create_augroup('my.augroup.term.winenter', {})
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd.startinsert()
    end
  end,
  desc = 'Enter terminal-mode immediately when entering a terminal buffer window.',
  group = augroup_term_autoinsert,
})

local augroup_cmdline_changed = vim.api.nvim_create_augroup('my.augroup.cmdlinechanged', {})
vim.api.nvim_create_autocmd('CmdlineChanged', {
  callback = function() vim.fn.wildtrigger() end,
})

