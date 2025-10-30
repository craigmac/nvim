-- nvim-treesitter is required
local ok, treesitter = pcall(require, 'nvim-treesitter')
if not ok then return end

local ok, textobjects = pcall(require, 'nvim-treesitter-textobjects')
if not ok then return end

textobjects.setup {
  move = { set_jumps = true },
  select = { lookahead = true }, -- jump forward like targets.vim
}

-- `i` and `a` textobjects for (c)lass and (f)unction, e.g., `vaf`, `dic`, `vif`
-- You can also use the capture groups defined in `textobjects.scm` for targets
local ts = require 'nvim-treesitter-textobjects.select'
vim.keymap.set({ 'x', 'o' }, 'ac', function() ts.select_textobject('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() ts.select_textobject('@class.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() ts.select_textobject('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'af', function() ts.select_textobject('@function.outer', 'textobjects') end)

-- redefine builtin ]m, ]], [m, et al. to use more accurate treesitter nodes
local mv = require('nvim-treesitter-textobjects.move')
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() mv.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() mv.goto_previous_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() mv.goto_next_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() mv.goto_previous_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() mv.goto_next_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() mv.goto_previous_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() mv.goto_next_end('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() mv.goto_previous_end('@class.outer', 'textobjects') end)
