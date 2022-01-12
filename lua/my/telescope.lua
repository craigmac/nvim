local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local layouts = require("telescope.actions.layout")
local pickers = require("telescope.pickers")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

require("telescope").setup({
	defaults = {
		path_display = { "absolute" },
		mappings = {
			i = {
				-- I don't want to go to Normal mode ever
				["<esc>"] = actions.close,
				["<C-o>"] = layouts.toggle_preview,
				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,
			},
		},
	},
	pickers = {
		-- change configs for each builtin picker (each key is a picker name)
		git_files = {
			theme = "dropdown",
			previewer = false,
		},
		spell_suggest = {
			theme = "cursor",
		},
		grep_string = {
			theme = "dropdown",
			previewer = false,
		},
		live_grep = {
			theme = "dropdown",
			previewer = false,
		},
		lsp_code_actions = {
			theme = "cursor",
		},
		find_files = {
			theme = "dropdown",
			previewer = false,
		},
		buffers = {
			theme = "dropdown",
			previewer = false,
		},
	},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

-- these need to come after main setup() call
require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
require("telescope").load_extension("gh")

vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope git_files<CR>")
vim.keymap.set("n", "<Leader>ee", "<Cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>bb", "<Cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<Leader><F1>", "<Cmd>Telescope help_tags<CR>")
vim.keymap.set("n", "<Leader>/", "<Cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<Leader><C-]>", "<Cmd>Telescope tags<CR>")
vim.keymap.set("n", "<Leader>?", "<Cmd>Telescope grep_string<CR>")
vim.keymap.set("n", "<Leader>:", "<Cmd>Telescope commands<CR>")
vim.keymap.set("n", "z=", "<Cmd>Telescope spell_suggest<CR>")
vim.keymap.set("n", "<M-.>", "<Cmd>Telescope lsp_code_actions<CR>")
vim.keymap.set("n", "<Leader>lo", "<Cmd>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<Leader>lO", "<Cmd>Telescope lsp_workspace_symbols<CR>")

vim.keymap.set("n", "<Leader>gis", "<Cmd>Telescope gh issue theme=dropdown<CR>")
vim.keymap.set("n", "<Leader>gpr", "<Cmd>Telescope gh pull_request theme=dropdown<CR>")
-- vim.keymap.set("n", "<Leader>g.", "<Cmd>lua require('telescope').extensions.gh.gist()<CR>")
