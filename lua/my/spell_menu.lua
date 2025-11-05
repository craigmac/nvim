-- WIP: translating from .plugin/spell_menu.vim
-- translated to lua from original $VIMRUNTIME/menu.vim
-- spell suggestions in a popup menu on z=

local function spell_popup()
  if changeitem and changeitem != '' then
    spell_del()
  end

  -- quick return if spell checking off or no language set
  if not vim.o.spell or vim.o.spelllang == '' then return end

  ---@type number byte index of current cursor position
  local cursor_col = vim.fn.col('.')
  ---@type string # The badly spelled word, or empty string if none found on line
  ---@type 'bad'|'rare'|'locale'|'caps' # Type of spelling error
  local bad_word, bad_type = vim.fn.spellbadword()
  
  -- NOTE: why do we do this?
  -- don't use any word after the cursor
  if vim.fn.col('.') > cursor_col then
    local bad_word = ''
  end

  -- we have a badly spelled word on current line
  if bad_word != '' then
    ---@type string[]|string
    local suggestions = spell_get_suggestions(bad_word, bad_type)
  end

  -- put cursor back to where it was when we started
  vim.fn.cursor(0, cursor_col)
end

---@param bad_word string
---@param 'bad'|'rare'|'locale'|'caps'
---@return string[]|string
local function spell_get_suggestions(bad_word, bad_type)
  if bad_type == 'caps' then
    ---@type string
    local suggestions = vim.fn.substitute(bad_word, '.*', '\u&', '')
  else
    ---@type string[]
    local suggestions = vim.fn.spellsuggest(bad_word, 10)
  end

  if type(suggestions) == 'table' then

  end

  return suggestions
end

local function spell_replace()
end

local function spell_del()
end

local augroup = vim.api.nvim_create_augroup('my.augroup.spelling.menu_popup', {})
vim.api.nvim_create_autocmd('MenuPopup', {
  callback = function()
    spell_popup()
  end,
  desc = 'Present a menu to correct a spelling mistake',
  group = augroup,
  pattern = '*',
})

