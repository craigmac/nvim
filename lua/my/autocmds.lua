local mygroup = vim.api.nvim_create_augroup('my.augroup', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.hl.on_yank() end,
  desc = 'Briefly highlight yanked text',
  group = mygroup,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'InsertLeave', 'TermLeave' }, {
  command = 'setlocal cursorline',
  desc = 'Turn on cursorline highlight.',
  group = mygroup,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'InsertEnter', 'TermEnter' }, {
  command = 'setlocal nocursorline',
  desc = 'Turn off cursorline highlight.',
  group = mygroup,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  command = 'setlocal nolist',
  desc = 'Turn off &list in insert-mode so no "trail:█" listchars shown while typing',
  group = mygroup,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  command = 'setlocal list',
  desc = 'Turn &list back on when leaving Insert mode so we see trailing whitespace.',
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

vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    local client = vim.api.nvim_get_chan_info(vim.v.event.chan or 0).client
    if client ~= nil and client.name == 'Firenvim' then
      vim.o.laststatus = 0
      vim.o.showtabline = 0
      vim.o.winbar = ''
      vim.o.background = 'light'
      vim.cmd.colorscheme('default')
      vim.o.spelloptions = 'camel' -- 'ConsideredFourSeparateWords' = 4 words to check
      vim.o.spellsuggest = 'best,5' -- only show 5 suggestions
      vim.o.spell = true
      vim.cmd.startinsert()
    end
  end,
})

