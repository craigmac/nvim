-- autogroup naming convention:
--
-- 'my.augroup.cursorline'    group of event(s) that triggers managing the 'cursorline' option
-- 'my.augroup.winenter'      WinEnter event. a general catch all that's not limited to one subject
-- 'my.augroup.term.winenter' WinEnter event, but specifically for terminal buffers

-- subject comes before the event, i.e., 'term.winenter' not 'winenter.term', so that all terminal-related
-- autocmds are easily found under 'my.augroup.term.*'

-- when turning off 'termguicolors' transparency will no longer work,
-- options related to that like winblend will break UI
local augroup = vim.api.nvim_create_augroup('my.augroup.optionset', {})
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = "termguicolors",
  callback = function(args)
    if vim.v.option_new == false then
      -- :set is not supposed to re-trigger OptionSet in the autocmd
      vim.o.winblend = 0
      vim.o.pumblend = 0
    elseif vim.v.option_new == true then
      vim.o.winblend = 10
      vim.o.pumblend = 10
    else
      vim.notify('[my.augroup.optionset]: "else" branch, `vim.v.option_new value` is: ' .. vim.v.option_new)
    end
  end,
})

local augroup_typ = vim.api.nvim_create_augroup('my.augroup.textyankpost', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  desc = 'Briefly highlight yanked text',
  group = augroup_typ,
})

local augroup_cursorline = vim.api.nvim_create_augroup('my.augroup.cursorline', {})
vim.api.nvim_create_autocmd({ 'WinEnter', 'InsertLeave', 'TermLeave' }, {
  callback = function(args)
    local bufnr = args.buf
    if vim.bo[bufnr].buftype == 'quickfix' then return end
    vim.wo.cursorline = true
  end,
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
    if ln > 1 and ln <= lastln then
      vim.cmd.normal({ 'g`"', bang = true })
    end
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
  group = augroup_external_ui,
})

local augroup_ts_ft = vim.api.nvim_create_augroup('my.augroup.treesitter.filetype', {})
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
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

    -- only in the GUI, which doesn't set `g:terminal_color_{0..15}`
    if vim.fn.has('gui_running') == 1 then
      -- 'Dimidium' palette (Microsoft Terminal theme)
      vim.api.nvim_set_hl(0, 'TermCursor', { bg = '#37e57b', fg = '#000000' })
      local ns_id = vim.api.nvim_create_namespace('my.terminal.colours')
      vim.api.nvim_set_hl(ns_id, 'Terminal', { bg = '#141414', fg = '#bab7b6' })
      vim.api.nvim_set_hl(ns_id, 'Visual', { bg = '#8db8e5', fg = '#000000' })
      vim.g.terminal_color_0 = '#000000'
      vim.g.terminal_color_1 = '#cf494c'
      vim.g.terminal_color_2 = '#60b442'
      vim.g.terminal_color_3 = '#db9c11'
      vim.g.terminal_color_4 = '#0575d8'
      vim.g.terminal_color_5 = '#af5ed2'
      vim.g.terminal_color_6 = '#1db6bb'
      vim.g.terminal_color_7 = '#bab7b6'
      vim.g.terminal_color_8 = '#817e7e'
      vim.g.terminal_color_9 = '#ff643b'
      vim.g.terminal_color_10 = '#37e57b'
      vim.g.terminal_color_11 = '#fccd1a'
      vim.g.terminal_color_12 = '#688dfd'
      vim.g.terminal_color_13 = '#ed6fe9'
      vim.g.terminal_color_14 = '#32e0fb'
      vim.g.terminal_color_15 = '#dee3e4'
    end
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
  callback = function()
    vim.fn.wildtrigger()
  end,
})
