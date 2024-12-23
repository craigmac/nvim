vim.keymap.set("n", "<Leader>w", "<Cmd>silent update ++p<CR>", { desc = '(w)rite' })
vim.keymap.set("n", "<Leader>xx", "<Cmd>source %<CR>", { desc = 'e(x)ecute/source buffer' })
vim.keymap.set("n", "<Leader>,", "<Cmd>edit $MYVIMRC<CR>")
vim.keymap.set("n", "zS", "<Cmd>Inspect<CR>")
vim.keymap.set("n", "gA", "<Cmd>digraphs!<CR>")

-- netrw's `:Rexplore` doesn't work until you've first used `:Explore`
vim.keymap.set("n", "<Leader>e", function()
  return vim.g.loaded_netrw and "<Cmd>Rex<CR>" or "<Cmd>Ex<CR>"
end, { expr = true, desc = '(e)xplore with netrw' })

vim.keymap.set({ "n", "x" }, "<Leader>y", '"+y', { desc = '(y)ank to unnamedplus' })
vim.keymap.set({ "n", "x" }, "<Leader>Y", '"+Y', { desc = '(Y)ank to unnamedplus' })
vim.keymap.set({ "n", "x" }, "<Leader>p", '"+p', { desc = '(p)aste from unnamedplus' })
vim.keymap.set({ "n", "x" }, "<Leader>P", '"+P', { desc = '(P)aste from unnamedplus' })

-- vim-unimpaired maps I use that weren't added to neovim
vim.keymap.set("n", "yol", "<Cmd>set list!<CR>")
vim.keymap.set("n", "yon", "<Cmd>set number!<CR>")
vim.keymap.set("n", "yoc", "<Cmd>set cursorline!<CR>")
vim.keymap.set("n", "yor", "<Cmd>set relativenumber!<CR>")
vim.keymap.set("n", "yow", "<Cmd>set wrap!<CR>")

vim.keymap.set("n", "]e", "<Cmd>m .+1<CR>")
vim.keymap.set("n", "[e", "<Cmd>m .-2<CR>")

vim.keymap.set("x", "]e", ":m '>+1 | gv<CR>")
vim.keymap.set("x", "[e", ":m '<-2 | gv<CR>")

-- Tab/S-Tab to cycle matches in / or ? searches, re: <C-z> here, see `:h 'wcm`
vim.keymap.set("c", "<Tab>", function()
  return string.match(vim.fn.getcmdtype(), '[/?]') and "<C-g>" or "<C-z>"
end, { expr = true })

vim.keymap.set("c", "<S-Tab>", function()
  return string.match(vim.fn.getcmdtype(), "[/?]") and "<C-t>" or "<S-C-z>"
end, { expr = true })

-- improve command-line history recall by using context-aware <Up><Down>
-- TODO: make a T() function that returns boolean for vim.fn like `if  T(pumvisible)  then...`
vim.keymap.set('c', '<C-p>', function() return vim.fn.pumvisible() >= 1 and "<C-p>" or "<Up>" end,
  { expr = true })
vim.keymap.set('c', '<C-n>', function() return vim.fn.pumvisible() >= 1 and "<C-n>" or "<Down>" end,
  { expr = true })
-- assign the non-context aware history recall to <Up><Down>
vim.keymap.set('c', '<Up>', function() return vim.fn.pumvisible() >= 1 and "<C-p>" or "<C-p>" end,
  { expr = true })
vim.keymap.set('c', '<Down>', function() return vim.fn.pumvisible() >= 1 and "<C-n>" or "<C-n>" end,
  { expr = true })

-- default wildmenu is vertical now and default keybinds are unintuitive
-- so make Left be Up (go up directory) and Right and Down (go into directory)
vim.keymap.set('c', '<Right>',
  function() return vim.fn.pumvisible() >= 1 and "<Down>" or "<Right>" end, { expr = true })
vim.keymap.set('c', '<Left>', function() return vim.fn.pumvisible() >= 1 and "<Up>" or "<Left>" end,
  { expr = true })

vim.keymap.set('n', 'j', function() return vim.v.count == 0 and 'gj' or 'j' end, { expr = true })
vim.keymap.set('n', 'k', function() return vim.v.count == 0 and 'gk' or 'k' end, { expr = true })

-- visual mode insert/append before/after each line
vim.keymap.set('x', 'I', function() return vim.fn.mode() == '[vV]' and '<C-v>^o^I' or 'I' end,
  { expr = true })
vim.keymap.set('x', 'A', function() return vim.fn.mode() == '[vV]' and '<C-v>0o$A' or 'A' end,
  { expr = true })

-- repeat last command on each visual selected line
vim.keymap.set('x', '.', ':normal .<CR>')

-- local job_id = 0

-- (t)oggle (t)erminal
vim.keymap.set('n', '<Leader>tt', function()
  vim.cmd.split()
  vim.cmd.wincmd("J")
  vim.cmd.term()
  vim.api.nvim_win_set_height(0, 10)
  -- job_id = vim.bo.channel
end, { desc = '(t)oggle (t)erminal' })

-- (m)ake in terminal, vim-dispatch inspired binding
vim.keymap.set('n', 'm<CR>', function()
  vim.cmd.split()
  vim.cmd.wincmd("J")
  vim.cmd.term('make')
  vim.api.nvim_win_set_height(0, 10)
end)

--(t)erminal (s)end example
-- vim.keymap.set('n', '<Leader>ts', function()
--   vim.fn.chansend(job_id, { "echo 'hi'\r" })
-- end)

vim.keymap.set('t', "<Esc><Esc>", "<C-\\><C-n>")
