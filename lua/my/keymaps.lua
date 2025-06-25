vim.keymap.set('n', '<Leader>w', '<Cmd>silent update ++p<CR>')
vim.keymap.set('n', '<Leader><CR>', '<Cmd>source %<CR>')
vim.keymap.set('n', '<Leader><Space>', '<Cmd>b #<CR>')
vim.keymap.set('n', '<Leader>,', ':<C-u>silent tabedit $MYVIMRC <Bar> :tcd %:h<CR>', { silent = true })
vim.keymap.set('n', "'", '`')
vim.keymap.set('n', 'zS', '<Cmd>Inspect<CR>')
vim.keymap.set('n', 'g:', ':<C-u>lua =')

vim.keymap.set('n', '<Leader>f', ':<C-u>f<Space>')
vim.keymap.set('n', 'j', function()
  return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj' end, { expr = true, silent = true })
vim.keymap.set('n', 'k', function()
  return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk' end, { expr = true, silent = true })
if not vim.pack then
  -- no plugins
  vim.keymap.set('n', '<Leader>f', ':<C-u>f<Space>')
end
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')

vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+Y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+pv\'[\']')
vim.keymap.set({ 'n', 'x' }, '<Leader>P', '"+Pv\'[\']')
vim.keymap.set('x', '.', ':normal! .<CR>')

-- n always goes down, N always goes up, and never think about it again
vim.cmd([[
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]
]])

vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')

-- some vim-unimpaired extras not shipped in $VIMRUNTIME/lua/vim/_defaults.lua
vim.keymap.set('x', '[e', ":move '<-2<cr>gv=gv", { silent = true })
vim.keymap.set('x', ']e', ":move '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('n', '[e', ":<C-u>move -2<cr>==", { silent = true })
vim.keymap.set('n', ']e', ":<C-u>move +1<CR>==", { silent = true })

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
