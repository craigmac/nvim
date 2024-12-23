local M = {}

local namespace_id = vim.api.nvim_create_namespace("brightline")
local current_line = nil
local brightened_groups = {}

-- Adjust the brightness of a color by a factor
local bit = require('bit')  -- Load the LuaJIT bit module
local function adjust_brightness(color, factor)
  if not color then return nil end
  local r = math.min(255, math.floor(bit.rshift(color, 16) * factor))  -- Get the red component
  local g = math.min(255, math.floor(bit.rshift(bit.band(color, 0x00FF00), 8) * factor))  -- Get the green component
  local b = math.min(255, math.floor(bit.band(color, 0x0000FF) * factor))  -- Get the blue component
  return bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b)  -- Combine the RGB components
end

-- Default colors if Normal group doesn't return usable values
local default_fg = 0xFFFFFF  -- white
local default_bg = 0x000000  -- black

-- Get or create a brightened highlight group for each group on the line
local function get_brightened_highlight_group(group, factor)
  if brightened_groups[group] then
    return brightened_groups[group]
  end

  -- Get the highlight group properties for the group
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })

  -- Fallback to default colors if no valid foreground or background is found
  local bright_fg = hl.foreground and adjust_brightness(hl.foreground, factor) or adjust_brightness(default_fg, factor)
  local bright_bg = hl.background and adjust_brightness(hl.background, factor) or adjust_brightness(default_bg, factor)

  -- Create and set the brightened highlight group
  local new_group = group .. "_bright"
  vim.api.nvim_set_hl(0, new_group, {
    foreground = bright_fg,
    background = bright_bg,
  })

  brightened_groups[group] = new_group
  return new_group
end

-- Function to brighten the current line's highlight groups
local function brighten_current_line()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row = cursor_pos[1] - 1 -- Convert to 0-based index

  -- If the cursor is still on the same line, do nothing
  if current_line == row then return end

  -- Clear previous highlights in the namespace to ensure only the current line is modified
  vim.api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)

  -- Update current line
  current_line = row

  -- Get the current line text
  local line_text = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

  -- Iterate over each column in the line and apply highlights
  local highlight_groups = vim.fn.synstack(row + 1, 1) -- Get the highlight groups at the first column (1-based)

  -- Apply brightened highlights for each group at this position
  for _, group in ipairs(highlight_groups) do
    local group_name = vim.fn.synIDattr(group, 'name')
    local bright_group = get_brightened_highlight_group(group_name, 1.2)

    -- Add the highlight for this group across the entire line
    for col = 0, #line_text do
      vim.api.nvim_buf_add_highlight(0, namespace_id, bright_group, row, col, col + 1)
    end
  end
end

-- Setup function
function M.setup()
  -- Automatically brighten current line when cursor moves
  vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
    callback = brighten_current_line,
  })

  -- Clear highlights when leaving the window
  vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
      vim.api.nvim_buf_clear_namespace(0, namespace_id, 0, -1)
      current_line = nil
    end,
  })
end

return M

