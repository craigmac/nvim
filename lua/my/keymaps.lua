vim.keymap.set('n', '<Leader>w', '<Cmd>silent update ++p<CR>')
vim.keymap.set('n', '<Leader><CR>', '<Cmd>source %<CR>')
vim.keymap.set('n', '<Leader><Space>', '<Cmd>b #<CR>')
vim.keymap.set('n', '<Leader>,', ':<C-u>silent tabedit $MYVIMRC <Bar> :tcd %:h<CR>', { silent = true })
vim.keymap.set('n', "'", '`')
vim.keymap.set('n', 'zS', '<Cmd>Inspect<CR>')
vim.keymap.set('n', 'g:', ':<C-u>lua =')
vim.keymap.set('n', 'gV', ':<C-u>normal! `[v`]<CR>')
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+Y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', "\"+pv'[']")
vim.keymap.set({ 'n', 'x' }, '<Leader>P', "\"+Pv'[']")
-- n always goes down, N always goes up, and never think about it again
vim.cmd([[
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
]])

vim.keymap.set('n', 'j', function()
  return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj'
end, { expr = true, silent = true })

vim.keymap.set('n', 'k', function()
  return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk'
end, { expr = true, silent = true })

-- (v)im (r)untime
vim.keymap.set('n', '<Leader>vr', function()
  local d = vim.env.VIMRUNTIME
  vim.cmd.tabedit(d)
  vim.cmd.tcd(d)
end, { silent = true })

-- (v)im (p)lugins
vim.keymap.set('n', '<Leader>vp', function()
  local d = vim.fn.stdpath('data') .. '/site/pack/core/opt'
  vim.cmd.tabedit(d)
  vim.cmd.tcd(d)
end, { silent = true })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')

vim.keymap.set('x', '.', ':normal! .<CR>')

vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')

-- replace standard dumb up/down with improved command-line-history-aware <Up><Down>
vim.keymap.set('c', '<C-p>', function() return vim.fn.pumvisible() >= 1 and '<C-p>' or '<Up>' end, { expr = true })
vim.keymap.set('c', '<C-n>', function() return vim.fn.pumvisible() >= 1 and '<C-n>' or '<Down>' end, { expr = true })

vim.keymap.set('n', '<Leader>e', function()
  -- `:Rex` command is defined until netrw is loaded
  if vim.g.loaded_netrw then
    if vim.w.netrw_rexlocal == 1 then
      return ':Rex<CR>'
    else -- not previously a netrw win - call `:Ex` instead to avoid error
      return ':Ex .<CR>'
    end
  end

  return ':Ex .<CR>'
end, { expr = true, silent = true })

-- (g)o (m)enu - overwrites default `:h gm` that I never use
vim.keymap.set('n', 'gm', function() require('my.menus').lsp_popup_menu() end, { desc = 'Contextual LSP popup menu' })
