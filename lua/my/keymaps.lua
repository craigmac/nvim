vim.keymap.set('n', '<Leader>w', '<Cmd>silent update ++p<CR>')
vim.keymap.set('n', '<Leader><CR>', '<Cmd>source %<CR>')
vim.keymap.set('n', '<Leader><Space>', '<Cmd>b #<CR>')
vim.keymap.set('n', '<Leader>,', ':<C-u>tabedit $MYVIMRC <Bar> :tcd %:h<CR>')
vim.keymap.set('n', "'", '`')
vim.keymap.set('n', 'zS', '<Cmd>Inspect<CR>')
vim.keymap.set('n', 'g:', ':<C-u>lua =')

vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+Y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+p')
vim.keymap.set({ 'n', 'x' }, '<Leader>P', '"+P')

vim.keymap.set('x', '.', ':normal! .<CR>')

vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', '(<CR>', '(<CR>)<Esc>O')
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O')
vim.keymap.set('i', '{,', '{<CR>},<Esc>O')
vim.keymap.set('i', '[<CR>', '[<CR>]<Esc>O')
vim.keymap.set('i', '[,', '[<CR>],<Esc>O')

-- `:h 'wcm` explains <C-z> here
vim.keymap.set(
  'c',
  '<Tab>',
  function() return string.match(vim.fn.getcmdtype(), '[/?]') and '<C-g>' or '<C-z>' end,
  { expr = true }
)

vim.keymap.set(
  'c',
  '<S-Tab>',
  function() return string.match(vim.fn.getcmdtype(), '[/?]') and '<C-t>' or '<S-C-z>' end,
  { expr = true }
)

-- improve command-line history recall by using context-aware <Up><Down>
vim.keymap.set('c', '<C-p>', function() return vim.fn.pumvisible() >= 1 and '<C-p>' or '<Up>' end, { expr = true })
vim.keymap.set('c', '<C-n>', function() return vim.fn.pumvisible() >= 1 and '<C-n>' or '<Down>' end, { expr = true })

vim.keymap.set('n', '<Leader>e', function()
  -- :Rex isn't defined until netrw is loaded
  if vim.g.loaded_netrw then
    -- from netrw source:
    -- com! Rexplore if exists("w:netrw_rexlocal")|call s:NetrwRexplore(w:netrw_rexlocal,exists("w:netrw_rexdir")? w:netrw_rexdir : ".")|else|call netrw#ErrorMsg(s:WARNING,"win#".winnr()." not a former netrw window",79)|endif
    if vim.w.netrw_rexlocal == 1 then
      return ':Rex<CR>'
    else
      return ':Ex<CR>'
    end
  end
  return ':Ex<CR>'
end, { expr = true })

-- (g)o (m)enu: popup the right-click menu at cursor position
-- overwrites default useless gm that I never use
vim.keymap.set('n', 'gm', function()
  local pos = vim.api.nvim_win_get_cursor(0)
  local row, col = pos[1] - 1, pos[2] + 2
  vim.api.nvim_input_mouse('right', 'press', '', 0, row, col)
end)

-- (t)oggle (t)erminal: opens or reuses visible terminal buffer in current tabpage
vim.keymap.set('n', '<Leader>tt', function()
  local curr_tab = vim.api.nvim_get_current_tabpage()
  local windows = vim.api.nvim_tabpage_list_wins(curr_tab)

  for _, winnr in ipairs(windows) do
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })

    if buftype == 'terminal' then
      vim.fn.win_gotoid(winnr)
      return
    end
  end

  vim.cmd.split()
  vim.cmd.wincmd('J')
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 10)
end)
