-- global variables and functions
My = {}

vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0
-- assembled from `highlight_group.c` in neovim source
vim.g.nvim_palette = {
  black = '#07080d', -- same as 'gray1', added for alias
  red = '#590008',
  green = '#005523',
  yellow = '#6b5300',
  blue = '#004c73',
  magenta = '#470045',
  cyan = '#007373',
  white = '#2c2e33',        -- same as 'gray3', added as alias
  bright_black = '#9b9ea4', -- same as 'gray4', added as alias
  bright_red = '#ffc0b9',
  bright_green = '#b3f6c0',
  bright_yellow = '#fce094',
  bright_blue = '#a6dbff',
  bright_magenta = '#ffcaff',
  bright_cyan = '#8cf8f7',
  bright_white = '#eef1f8', -- same as 'gray1', added as alias
  gray1 = '#07080d',
  gray2 = '#14161b',        -- hl-Normal guibg in bg=dark, guifg in bg=light
  gray3 = '#2c2e33',
  gray4 = '#4f5258',
  bright_gray1 = '#eef1f8',
  bright_gray2 = '#e0e2ea', -- hl-Normal guibg in bg=light
  bright_gray3 = '#c4c6cd',
  bright_gray4 = '#9b9ea4',
}
-- when aligning with gl/gL reduces spaces to minimum required
vim.g.lion_squeeze_spaces = 1

---@param value? number Minwid field value or 0 if no N specified
---@param mouse_clicks number How many mouse clicks - to detect double click if needed
---@param mouse_button string Mouse button used, typically l, r, and m but can be any lowercase ASCII
---@param mods string Modifiers pressed, contains s if shift, c for control, a for alt and m for meta
function My.ShowDiagnostics(value, mouse_clicks, mouse_button, mods)
  vim.diagnostic.open_float({ scope = 'buffer' })
end

function My.diagnostic_status()
  -- prioritize user set signs if they exist
  local user_signs = vim.tbl_get(vim.diagnostic.config(), 'signs', 'text') or {}
  local signs = vim.tbl_extend('keep', user_signs, { 'E:', 'W:', 'I:', 'H:' })

  local counts = vim.diagnostic.count(0)
  local result = vim.iter(pairs(counts))
      :map(function(severity, count)
        return ('%s%s'):format(signs[severity], count)
      end)
      :join(' ')
  return result
  -- this wouldn't work...even when using %{% .. %} form to re-evalute
  -- return ('%s%s%s'):format('%@v:lua._G.Press@', result, '%X')
end

-- function My.TabLine ()
--   return table.concat({
--     '%{% tabpagenr() %}',
--     ' %t'
--   })
-- end

---@return string # `:help 'stl` format string
function My.StatusLine()
  local parts = {
    ' @',
    '%{fnamemodify(getcwd(0), ":t")} ',
    '│ %<%.50(%f%)',
    '%( %H %W %M %R%)',
    '%( %@v:lua.My.ShowDiagnostics@%{v:lua.My.diagnostic_status()}%X%)',
    '%=',
    '%{reg_recording() == "" ? "" : "foo"}',
    '%{% &showcmdloc == "statusline" ? "%.10(%S…%)" : "" %}',
    ' %( #%l–%L:%v%)',
    '│ %.10(%{&filetype}%) ',
    '│ %P ',
  }
  return table.concat(parts)
end

---https://github.com/neovim/neovim/pull/34545
---
---Evaluated when searching for file names using the `:find` command
function My.FindFunc(name)
  local search_pattern = name or '.'
  local cmd = vim.list_extend({
    'rg', '--files', '--color', 'never', '--glob', search_pattern
  }, vim.opt.path:get())
  local res = vim.system(cmd, { text = true }):wait()
  return vim.split(res.stdout, '\n', { trimempty = true })
end
