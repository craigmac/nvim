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

vim.api.nvim_create_autocmd('CmdlineChanged', {
  desc = 'Autocompletion suggestions as you type in search and commandline',
  group = mygroup,
  pattern = '[:/\\?]',
  command = 'call wildtrigger()',
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
      vim.o.spelllang = 'canadian' -- « Canadien, s'îl vous plait! »
      vim.o.spelloptions = 'camel' -- 'ConsideredFourSeparateWords' = 4 words to check
      vim.o.spellsuggest = 'best,5' -- only show 5 suggestions
      vim.o.spell = true
      vim.cmd.startinsert()
    end
  end,
})

-- annotate :terminal prompt marks if OSC 133 is set correctly on shell prompt,
-- use [[ and ]] in normal mode to jump around
vim.api.nvim_create_autocmd('TermOpen', {
  command = 'setlocal signcolumn=auto',
})
local ns = vim.api.nvim_create_namespace('my.terminal.prompt')
vim.api.nvim_create_autocmd('TermRequest', {
  callback = function(args)
    if string.match(args.data.sequence, '^\027]133;A') then
      ---@type integer
      local lnum = args.data.cursor[1]
      vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
        sign_text = '▶',
        sign_hl_group = 'SpecialChar',
      })
    end
  end,
})
