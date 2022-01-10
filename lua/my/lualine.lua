require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "github",
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			-- changes mode indicator to single character for space savings
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
		},
		lualine_b = { "branch", "diagnostics" },
		lualine_c = { "%f" },
		lualine_x = {},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "%f" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
