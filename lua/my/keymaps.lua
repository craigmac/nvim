vim.keymap.set('n', '<Leader>w', '<Cmd>silent update ++p<CR>')
vim.keymap.set('n', '<Leader><CR>', '<Cmd>source %<CR>')
vim.keymap.set('n', '<Leader><Space>', '<Cmd>b #<CR>')
vim.keymap.set('n', '<Leader>,', '<Cmd>edit $MYVIMRC<CR>', { silent = true })
vim.keymap.set('n', 'zS', '<Cmd>Inspect<CR>')
vim.keymap.set('n', 'g:', ':<C-u>lua =')
vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+Y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', "\"+pv'[']")
vim.keymap.set({ 'n', 'x' }, '<Leader>P', "\"+Pv'[']")

-- `n` and `;` always go forward and `N` and `,` always goes backwards - never think about it again!
vim.cmd([[
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
]])

vim.keymap.set('n', 'j', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj' end, { expr = true })
vim.keymap.set('n', 'k', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk' end, { expr = true })

vim.keymap.set('n', '<Leader>vr', function()
  local d = vim.env.VIMRUNTIME
  vim.cmd.tabedit(d)
  vim.cmd.tcd(d)
end, { silent = true })

vim.keymap.set('n', '<Leader>vp', function()
  local d = vim.fn.stdpath('data') .. '/site/pack/core/opt/'
  vim.cmd.tabedit(d)
  vim.cmd.tcd(d)
end, { silent = true })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')

vim.keymap.set('x', '.', ':normal! .<CR>')

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
  elseif vim.g.loaded_netrwPlugin ~= nil then
    return '<Cmd>Explore .<CR>'
  else
    vim.cmd.packadd('netrw')
    return '<Cmd>Explore .<CR>'
  end
end, { expr = true, silent = true })

-- (g)o (m)enu - overwrites default `:h gm` that I never use
vim.keymap.set('n', 'gm', function() require('my.menus').lsp_popup_menu() end)

-- alt. French digraphs for default e' e`|e! c,
vim.fn.digraph_setlist({
  {'e/',  'é'}, -- defaults: e'
  {'e\\', 'è'}, -- defaults: e` e!
  {'c?',  'ç'}, -- defaults: c,
})
