local mygroup = vim.api.nvim_create_augroup('my.augroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
  desc = 'Briefly highlight yanked text',
  group = mygroup,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'InsertLeave' }, {
  command = 'setlocal cursorline',
  desc = 'Turn on cursorline highlight.',
  group = mygroup,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave', 'InsertEnter' }, {
  command = 'setlocal nocursorline',
  desc = 'Turn off cursorline highlight.',
  group = mygroup,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local ln = vim.fn.line('\'"')
    local lastln = vim.fn.line('$')
    if ln > 1 and ln <= lastln then vim.cmd.normal({ 'g`"', bang = true }) end
  end,
  desc = 'Goto last edit position after reading a buffer.',
  group = mygroup,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local ok, _ = pcall(vim.treesitter.start)
    if not ok then return end
    -- only set this if we know treesitter started without error
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- if additional legacy regex syntax is needed
    -- vim.bo[args.buf].syntax = 'on'
  end,
  desc = 'Try starting treesitter, ignoring errors.',
  group = mygroup,
})

-- requires https://github.com/neovim/neovim/pull/34761
vim.api.nvim_create_autocmd('CmdlineChanged', {
  desc = 'Autocompletion suggestions as you type in search and commandline',
  group = mygroup,
  pattern = '[:/\\?]',
  callback = function(ev)
    local cmdline = vim.fn.getcmdline()
    local curpos = vim.fn.getcmdpos()
    local wildmenu_showing = vim.fn.wildmenumode() == 1
    local cmdmode = ev.file == ':'
    local trigger_re = '[%w/:%*%.%-_]$'
    local trigger_found = cmdline:find(trigger_re) ~= nil

    -- example matches: `:1`, `:0,10` `:,50` `:50+` `:,25-` `:50+10`, `:10+,15-`
    local range_re = '^[%d,%+%-]+$'
    local only_range_found = cmdline:find(range_re) ~= nil

    -- any characters still to process in the queue, like in a paste scenario?
    local typeahead = vim.fn.getchar(1) ~= 0
    local cursor_not_at_eol = curpos ~= #cmdline + 1

    -- bail conditions - don't send char to trigger completion
    if typeahead or wildmenu_showing or cursor_not_at_eol or (only_range_found and cmdmode) or not trigger_found then
      return
    end

    -- turn off event temporarily to avoid retriggering and doing redundant completion attempts
    vim.opt.eventignore:append('CmdlineChanged')

    vim.api.nvim_feedkeys(string.char(vim.o.wildcharm), 't', false)

    -- Remove expansion char from line if there were no completions. `:Fail ` becomes `:Fail`
    vim.schedule(function() 
      local wcm = string.char(vim.o.wildcharm)
      local res = vim.fn.getcmdline():gsub(wcm, '')
      vim.fn.setcmdline(res)
    end)
   
    vim.schedule(function() vim.opt.eventignore:remove('CmdlineChanged') end)
  end
})
