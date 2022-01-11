vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer", "lspinfo" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

require("indent_blankline").setup({
	-- show_current_context = true,
	-- show_current_context_start = true,
	-- --Map blankline
})

vim.keymap.set("n", "<F12>", "<Cmd>IndentBlanklineToggle!<CR>")
-- vim.cmd([[nnoremap <F12> :IndentBlanklineToggle<CR>]])
