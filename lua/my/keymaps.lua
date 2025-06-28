vim.keymap.set('n', '<Leader>w', '<Cmd>silent update ++p<CR>', { desc = 'Write buffer if needed, creating intermediate dirs'})
vim.keymap.set('n', '<Leader><CR>', '<Cmd>source %<CR>', { desc = 'Source current buffer'})
vim.keymap.set('n', '<Leader><Space>', '<Cmd>b #<CR>', { desc = 'Switch to last buffer'})
vim.keymap.set('n', '<Leader>,', ':<C-u>silent tabedit $MYVIMRC <Bar> :tcd %:h<CR>', { silent = true })
vim.keymap.set('n', "'", '`', { desc = 'Map easier to type version to be the more accurate location marker'})
vim.keymap.set('n', 'zS', '<Cmd>Inspect<CR>')
vim.keymap.set('n', 'g:', ':<C-u>lua =', { desc = 'Evaluate lua expression and print the result' })
vim.keymap.set('n', 'gV', ':<C-u>normal! `[v`]<CR>', { desc = 'Visually select last edited/pasted region' })
vim.keymap.set('n', 'j', function()
  return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj' end, { expr = true, silent = true })
vim.keymap.set('n', 'k', function()
  return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk' end, { expr = true, silent = true })
if not vim.pack then vim.keymap.set('n', '<Leader>f', ':<C-u>f **/', { desc = 'budget fzf'}) end

vim.keymap.set('n', '<Leader>vr', function()
  local d = vim.env.VIMRUNTIME
  vim.cmd.tabedit(d)
  vim.cmd.tcd(d)
end, { desc = 'Tabedit $VIMRUNTIME', silent = true })

vim.keymap.set('n', '<Leader>vp', function()
  local d = vim.fn.stdpath('data')..'/site/pack/core/opt'
  vim.cmd.tabedit(d)
  vim.cmd.tcd(d)
end, { desc = 'Open netrw to plugin install directory', silent =  true })


vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Escape terminal mode back to normal mode'})
vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>', { desc = 'Escape terminal mode back to normal mode'})

vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y', { desc = 'Target system clipboard register'})
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+Y', { desc = 'Save Y to system clipboard register'})
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+pv\'[\']', { desc = 'Paste from system clipboard and reselect'})
vim.keymap.set({ 'n', 'x' }, '<Leader>P', '"+Pv\'[\']', { desc = 'Paste from system clipboard and reselect'})
vim.keymap.set('x', '.', ':normal! .<CR>', { desc = 'Run repeat operator on selected lines'})

-- n always goes down, N always goes up, and never think about it again
vim.cmd([[
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
]])

vim.keymap.set('i', 'kj', '<Esc>', { desc = 'Mash jk or kj to exit insert mode '})
vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Mash jk or kj to exit insert mode '})

-- some vim-unimpaired extras not shipped in $VIMRUNTIME/lua/vim/_defaults.lua
vim.keymap.set('x', '[e', ":move '<-2<cr>gv=gv", { silent = true, desc = 'Move visual range up' })
vim.keymap.set('x', ']e', ":move '>+1<CR>gv=gv", { silent = true, desc = 'Move visual range down' })
vim.keymap.set('n', '[e', ":<C-u>move -2<cr>==", { silent = true, desc = 'Move current line up' })
vim.keymap.set('n', ']e', ":<C-u>move +1<CR>==", { silent = true, desc = 'Move current line down' })

-- vim-unimpaired 'yo<key>' option toggles
local toggleable_opts = {
  c = 'cursorline',
  l = 'list',
  s = 'spell',
  ['|'] = 'cursorcolumn',
  n = 'number',
  r = 'relativenumber',
}
for k,v in pairs(toggleable_opts) do
  vim.keymap.set('n', string.format('yo%s', k), string.format('<Cmd>set %s!<CR>', v))
end

vim.keymap.set('n', 'yov', function()
  return string.format(':<C-u>set virtualedit%s=all<CR>', vim.o.virtualedit == "" and '+' or '-')
end, { expr = true })

-- `:h 'wcm` explains <C-z> here
vim.keymap.set( 'c', '<Tab>', function()
  return string.match(vim.fn.getcmdtype(), '[/?]') and '<C-g>' or '<C-z>' end, { expr = true })

vim.keymap.set( 'c', '<S-Tab>', function()
  return string.match(vim.fn.getcmdtype(), '[/?]') and '<C-t>' or '<S-C-z>' end, { expr = true })

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
      return ':Ex<CR>'
    end
  end
  return ':Ex<CR>'
end, { expr = true, silent = true })

-- (g)o (m)enu: popup the right-click menu at cursor position
-- overwrites default `:h gm` that I never use
vim.keymap.set('n', 'gm', function() vim.cmd.popup('PopUp') end)

-- (t)oggle (t)erminal: opens or reuses visible terminal buffer in current tabpage
vim.keymap.set('n', '<Leader>tt', function()
  local curr_tab = vim.api.nvim_get_current_tabpage()
  local windows = vim.api.nvim_tabpage_list_wins(curr_tab)
  -- reuse any existing :term in tabpage
  for _, winnr in ipairs(windows) do
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
    if buftype == 'terminal' then
      vim.fn.win_gotoid(winnr)
      vim.cmd.startinsert()
      return
    end
  end
  -- no reusable :term found, start new terminal
  vim.cmd.split()
  vim.cmd.wincmd('J')
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 10)
  vim.cmd.startinsert()
end)
