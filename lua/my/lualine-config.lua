require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "github",
    always_divide_middle = true,
  },
  sections = {
    -- If I want to see single char showing  current mode:
    --lualine_a = {
    --	{
    --		"mode",
    --		fmt = function(str)
    --			return str:sub(1, 1)
    --		end,
    --	},
    --},
    lualine_a = {},
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
}

-- TODO: add truncation of parts for <81 chars width:
-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#truncating-components-in-smaller-window
