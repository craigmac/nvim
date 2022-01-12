-- Following:
-- https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md#guide-to-your-first-picker

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local colors = function(opts)
	opts = opts or {}
	pickers.new(opts, {
		prompt_title = "Pick a color to show inspected value.",
		finder = finders.new_table({
			results = {
				{ "red", "#ff0000", "display value for red" },
				{ "green", "#00ff00", "display value for green" },
				{ "blue", "#0000ff", "display value for blue" },
			},
			-- Does a for-each loop on the results table, setting current table to entry.
			-- Think of it as massaging the raw data you get from 'results' table.
			entry_maker = function(entry)
				return {
					value = entry,
					-- required. string or function(tbl), which has access to 'value' and 'ordinal'
					display = entry[1],
					-- required. used for sorting.
					ordinal = entry[1],
				}
			end,
		}),
		sorter = conf.generic_sorter(opts),
		-- replace fn called when 'select_default' called (mapped to <CR> by default)
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				-- to show that the selection is actually a table with entry 1 being the string
				print(vim.inspect(selection))
				-- This just prints the string beside the cursor in the prompt on <CR>
				-- vim.api.nvim_put({ selection[1] }, "", false, true)
				--
			end)
			return true
		end,
	}):find()
end

-- to execute on re-source
-- colors(require("telescope.themes").get_dropdown({}))

local change_dir = function(opts)
	opts = opts or {}
	pickers.new(opts, {
		prompt_title = "Change Present Working Directory",
		finder = finders.new_oneshot_job({ "fd", "-a", "-d", "1", "-td", "-c", "never", ".", "~git" }, {
			entry_maker = function(entry)
				return {
					value = entry,
					display = entry[1],
					ordinal = entry[1],
				}
			end,
		}),
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
