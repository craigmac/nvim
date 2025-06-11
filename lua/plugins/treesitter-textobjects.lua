require('nvim-treesitter-textobjects').setup({
  move = { set_jumps = true },
  select = { lookahead = true }, -- jump forward like targets.vim
})

-- You can use the capture groups defined in `textobjects.scm`
local ts = require('nvim-treesitter-textobjects.select')

-- `i` and `a` textobjects for (f)unction and (c)lass
vim.keymap.set({ "x", "o" }, "af", function() ts.select_textobject("@function.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "if", function() ts.select_textobject("@function.inner", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ac", function() ts.select_textobject("@class.outer", "textobjects") end)
vim.keymap.set({ "x", "o" }, "ic", function() ts.select_textobject("@class.inner", "textobjects") end)

-- (a)round (s)cope textobject - this would override 's' default, 'sentence' textobject
vim.keymap.set({ "x", "o" }, "as", function() ts.select_textobject("@local.scope", "locals") end)

local mv = require('nvim-treesitter-textobjects.move')

-- redefine builtin ]m, ]], [m, et al. to use treesitter
vim.keymap.set({ "n", "x", "o" }, "]m", function() mv.goto_next_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[m", function() mv.goto_previous_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "]M", function() mv.goto_next_end("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[M", function() mv.goto_previous_end("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "]]", function() mv.goto_next_start("@class.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[[", function() mv.goto_previous_start("@class.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "][", function() mv.goto_next_end("@class.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[]", function() mv.goto_previous_end("@class.outer", "textobjects") end)

