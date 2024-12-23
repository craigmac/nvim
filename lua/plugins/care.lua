vim.keymap.set("i", "<c-j>", function()
  vim.snippet.jump(1)
end)

vim.keymap.set("i", "<c-k>", function()
  vim.snippet.jump(-1)
end)

vim.keymap.set("i", "<c-space>", function()
  require("care").api.complete()
end)

vim.keymap.set("i", "<C-y>", "<Plug>(CareConfirm)")
vim.keymap.set("i", "<C-e>", "<Plug>(CareClose)")
vim.keymap.set("i", "<Tab>", "<Plug>(CareSelectNext)")
vim.keymap.set("i", "<S-tab>", "<Plug>(CareSelectPrev)")

vim.keymap.set("i", "<C-f>", function()
  if require("care").api.doc_is_open() then
    require("care").api.scroll_docs(4)
  else
    vim.api.nvim_feedkeys(vim.keycode("<c-f>"), "n", false)
  end
end)

vim.keymap.set("i", "<c-d>", function()
  if require("care").api.doc_is_open() then
    require("care").api.scroll_docs(-4)
  else
    vim.api.nvim_feedkeys(vim.keycode("<c-d>"), "n", false)
  end
end)
