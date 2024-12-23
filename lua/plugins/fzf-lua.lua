-- https://github.com/ibhagwan/fzf-lua
local fzf = require('fzf-lua')

fzf.setup({
  winopts = { fullscreen = true },
  keymap = {
    builtin = {
      true, -- override the defaults
      ["<C-/>"] = "toggle-preview",
      ["<C-d>"] = "preview-page-down",
      ["<C-u>"] = "preview-page-up",
    },
  },
})

vim.keymap.set("n", "<Leader><Space>", "<Cmd>FzfLua<CR>")
vim.keymap.set("n", "<Leader>f", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>b", "<Cmd>b #<CR>")
vim.keymap.set("n", "<Leader>/", fzf.live_grep_native)
vim.keymap.set("n", "<Leader><F1>", fzf.helptags)

