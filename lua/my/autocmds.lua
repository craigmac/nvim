local myaugroup = vim.api.nvim_create_augroup('my.augroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = myaugroup,
})

-- filetypes to turn off numbers/listchars/cursorline/other things
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'qf', 'git', 'fugitiveblame' },
  callback = function()
    vim.wo.cursorline = false
    vim.wo.list = false
    vim.wo.number = false
    vim.wo.relativenumber = false
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'fugitiveblame', 'git', 'qf' },
  callback = function()
    vim.cmd.normal('A')
  end,
  group = myaugroup,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'TermLeave', 'InsertLeave' }, {
  command = 'setlocal cursorline',
  group = myaugroup,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'TermEnter', 'InsertEnter' }, {
  command = 'setlocal nocursorline',
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
  group = myaugroup,
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
  group = myaugroup,
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
