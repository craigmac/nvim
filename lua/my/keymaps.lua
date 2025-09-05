vim.keymap.set('n', '<Leader>w', '<Cmd>silent update ++p<CR>')
vim.keymap.set('n', '<Leader><CR>', '<Cmd>source %<CR>')
vim.keymap.set('n', '<Leader><Space>', '<Cmd>b #<CR>')
vim.keymap.set('n', '<Leader>,', ':<C-u>silent tabedit $MYVIMRC <Bar> :tcd %:h<CR>', { silent = true })
vim.keymap.set('n', 'zS', '<Cmd>Inspect<CR>')
vim.keymap.set('n', 'g:', ':<C-u>lua =')
-- visually select the last changed/yanked text
vim.keymap.set('n', 'gV', ':<C-u>normal! `[v`]<CR>')
-- n always goes 'down', N always goes 'up' and never think about this again
vim.keymap.set('n', 'n', ":<C-u>normal! <C-r>='Nn'[v:searchforward]<CR><CR>")
vim.keymap.set('n', 'N', ":<C-u>normal! <C-r>='nN'[v:searchforward]<CR><CR>")
vim.keymap.set('n', 'j', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'j' or 'gj' end, { expr = true })
vim.keymap.set('n', 'k', function() return (vim.v.count > 0 or not vim.wo.wrap) and 'k' or 'gk' end, { expr = true })
vim.keymap.set('n', '<Leader>vr', ':<C-u>silent tabedit $VIMRUNTIME | tcd $VIMRUNTIME<CR>')
vim.keymap.set('n', '<Leader>vp', ':tabe <C-r>=stdpath("data").."/site/pack"<CR> | tcd <C-r>=stdpath("data")<CR><CR>')

vim.keymap.set({ 'n', 'x' }, '<Leader>y', '"+y')
vim.keymap.set({ 'n', 'x' }, '<Leader>Y', '"+Y')
vim.keymap.set({ 'n', 'x' }, '<Leader>p', "\"+pv'[']")
vim.keymap.set({ 'n', 'x' }, '<Leader>P', "\"+Pv'[']")

-- -- BUG: maybe not working?
-- vim.keymap.set('i', '<C-r>', '')

-- ol' trusty backup
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')
-- GUIs and some terminals can distinguish <C-[> from <Esc> now, so bind that also
vim.keymap.set('t', '<C-[><C-[>', '<C-\\><C-n>')

-- perform last change `:h .` on each line in visual range
vim.keymap.set('x', '.', ':normal! .<CR>')

-- use the history-aware <Up><Down> as default when popup is not visible
vim.keymap.set('c', '<C-p>', function() return vim.fn.pumvisible() >= 1 and '<C-p>' or '<Up>' end, { expr = true })
vim.keymap.set('c', '<C-n>', function() return vim.fn.pumvisible() >= 1 and '<C-n>' or '<Down>' end, { expr = true })

vim.keymap.set('n', '<Leader>e', function()
  if vim.g.loaded_netrw then
    -- avoids error if the window was not previously a netrw window
    if vim.w.netrw_rexlocal == 1 then
      return ':Rex<CR>'
    else
      return ':Ex .<CR>'
    end
  end
  -- :Rex is undefined until netrw fully loaded, use `:Ex` which is always defined
  return ':Ex .<CR>'
end, { expr = true, silent = true })

-- experiment with menus
vim.keymap.set('n', 'gm', function() require('my.menus').lsp_popup_menu() end)
