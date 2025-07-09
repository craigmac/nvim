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

-- set in $VIMRUNTIME/lua/vim/_defaults.lua but doesn't show float automatically
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true, wrap = false }) end)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true, wrap = false }) end)
vim.keymap.set('n', '[D', function() vim.diagnostic.jump({ count = 999, float = true, wrap = false }) end)
vim.keymap.set('n', '[D', function() vim.diagnostic.jump({ count = -999, float = true, wrap = false }) end)

vim.keymap.set('n', 'j', function()
  return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj'
end, { expr = true, silent = true })

vim.keymap.set('n', 'k', function()
  return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk'
end, { expr = true, silent = true })

if not vim.pack then
  vim.keymap.set('n', '<Leader>f', ':<C-u>f **/')
end

vim.keymap.set('n', '<Leader>vr', function()
  local d = vim.env.VIMRUNTIME
  vim.cmd.tabedit(d)
  vim.cmd.tcd(d)
end, { silent = true })

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

-- `:h 'wcm` explains <C-z> here
vim.keymap.set('c', '<Tab>', function()
  return string.match(vim.fn.getcmdtype(), '[/?]') and '<C-g>' or '<C-z>'
end, { expr = true })

vim.keymap.set('c', '<S-Tab>', function()
  return string.match(vim.fn.getcmdtype(), '[/?]') and '<C-t>' or '<S-C-z>'
end, { expr = true })

-- replace standard dumb up/down with improved command-line-history-aware <Up><Down>
vim.keymap.set('c', '<C-p>', function() return vim.fn.pumvisible() >= 1 and '<C-p>' or '<Up>' end, { expr = true })
vim.keymap.set('c', '<C-n>', function() return vim.fn.pumvisible() >= 1 and '<C-n>' or '<Down>' end, { expr = true })

vim.keymap.set('n', '<Leader>e', function()
  -- :Rex isn't defined until netrw is loaded
  if vim.g.loaded_netrw then
    -- if current win was not previously a netrw window we have to call `:Ex` instead to avoid error
    if vim.w.netrw_rexlocal == 1 then
      return ':Rex<CR>'
    else
      return ':Ex .<CR>'
    end
  end
  return ':Ex .<CR>'
end, { expr = true, silent = true })

-- (g)o (m)enu: popup the right-click menu at cursor position
-- overwrites default `:h gm` that I never use
-- vim.keymap.set('n', 'gm', function()
--   ---@type vim.lsp.Client[]|{}
--   local clients = vim.lsp.get_clients({ bufnr = 0 })
--
--   if vim.tbl_isempty(clients) then
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Show\\ Code\\ actions' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Go\\ to\\ declaration' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Go\\ to\\ type\\ definition' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Go\\ to\\ references' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Rename\\ symbol' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Show\\ Document\\ symbols' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Show\\ incoming\\ calls' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Show\\ outgoing\\ calls' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Toggle\\ inlay-hints' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Show\\ Workspace\\ symbols' } })
--     vim.cmd.aunmenu({ args = { 'disable', 'PopUp.Format\\ buffer' } })
--   end
--   -- if #clients > 1 then
--     -- loop to check what methods are supported in each attached lsp server
--     -- for 
--   -- end
--   vim.cmd.popup('PopUp')
-- end)

-- (g)o (m)enu - overwrites default `:h gm` that I never use
