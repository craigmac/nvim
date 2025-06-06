local mygroup = vim.api.nvim_create_augroup('my.augroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
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
    if ln > 1 and ln <= lastln then
      vim.cmd.normal({ 'g`"', bang = true })
    end
  end,
  desc = 'Goto last edit position after reading a buffer.',
  group = mygroup,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function(args)
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'msgbox',
  callback = function(ev) end,
  desc = 'Settings for message box window when using vim._extui module.',
  group = mygroup,
})
