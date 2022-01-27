-- Following:
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#guide-to-your-first-picker

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local change_dir = function(opts)
	opts = opts or {}
	-- TODO: add fallback to find if not fd
	-- https://github.com/nvim-telescope/telescope.nvim/blob/015a35626d5a293dc9c19dc2bb301f25850961f6/lua/telescope/builtin/files.lua#L147
	local find_command = { "fd", "-a", "-d", "1", "-td", "-c", "never", ".", vim.fn.expand("~/git") }
	-- local find_command = { "fd", "." }
	-- strings with ~ are NOT expanded and silently fail!
	-- local find_command = { "find", vim.fn.expand("~/git") }

	pickers.new(opts, {
		prompt_title = "Change Present Working Directory",
		finder = finders.new_oneshot_job(find_command, opts),
		sorter = conf.generic_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				print(vim.inspect(selection))
			end)
			return true
		end,
	}):find()
end

change_dir(require("telescope.themes").get_dropdown({}))
--
-- local find_command = { "fd", "-a", "-d", "1", "-td", "-c", "never", "." }
-- print(vim.inspect(find_command))
-- local command = find_command[1]
-- print(vim.inspect(command))
