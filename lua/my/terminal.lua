-- :terminal buffers

local augroup = vim.api.nvim_create_augroup('my.augroup.terminal', {})

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
  group = augroup
})

vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.wo.signcolumn = 'auto'
    vim.cmd.startinsert()
  end,
  desc = 'When terminal job starting. Used to configure terminal buffer.',
  group = augroup
})

vim.api.nvim_create_autocmd('WinEnter', {
  desc = 'Enter terminal-mode immediately when entering a terminal buffer window.',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd.startinsert()
    end
  end,
  group = augroup
})
