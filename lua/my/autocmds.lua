local myaugroup = vim.api.nvim_create_augroup('my.augroup', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
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
  group = myaugroup,
})
