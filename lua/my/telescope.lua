require("telescope").setup({
	defaults = {
		path_display = { "absolute" },
		mappings = {
			i = {
				-- I don't want to go to Normal mode ever
				["<esc>"] = require("telescope.actions").close,
				["<C-o>"] = require("telescope.actions.layout").toggle_preview,
				["<C-Down>"] = require("telescope.actions").cycle_history_next,
				["<C-Up>"] = require("telescope.actions").cycle_history_prev,
			},
		},
	},
	pickers = {
		-- default configs for each builtin picker
		git_files = {
			theme = "dropdown",
			previewer = false,
			prompt_title = false,
		},
		find_files = {
			theme = "dropdown",
		},
		buffers = {
			theme = "dropdown",
			prompt_title = false,
		},
		spell_suggest = {
			theme = "cursor",
		},
		help_tags = {
			theme = "dropdown",
		},
		live_grep = {
			theme = "dropdown",
		},
		tags = {
			theme = "dropdown",
		},
		grep_string = {
			theme = "ivy",
		},
		lsp_code_actions = {
			theme = "cursor",
		},
	},
	extensions = {},
})
require("telescope").load_extension("fzf")

local map = vim.api.nvim_set_keymap
local opts = { silent = true, noremap = true }

map("n", "<C-p>", "<Cmd>Telescope git_files<CR>", opts)
map("n", "<Leader>e", "<Cmd>Telescope find_files<CR>", opts)
map("n", "<Leader>b", "<Cmd>Telescope buffers<CR>", opts)
map("n", "<Leader><F1>", "<Cmd>Telescope help_tags<CR>", opts)
map("n", "<Leader>/", "<Cmd>Telescope live_grep<CR>", opts)
map("n", "<Leader><C-]>", "<Cmd>Telescope tags<CR>", opts)
map("n", "<Leader>?", "<Cmd>Telescope grep_string<CR>", opts)
map("n", "z=", "<Cmd>Telescope spell_suggest<CR>", opts)
map("n", "<M-.>", "<Cmd>Telescope lsp_code_actions<CR>", opts)
map("n", "<Leader>o", "<Cmd>Telescope lsp_document_symbols<CR>", opts)
map("n", "<Leader>O", "<Cmd>Telescope lsp_workspace_symbols<CR>", opts)
