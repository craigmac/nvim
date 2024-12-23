local M = {}

local function get_recording_register()
  local recording_register = vim.fn.reg_recording()
  return recording_register == '' and '' or 'recording @' .. recording_register
end

local function get_lsp_diagnostics()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(bufnr)
  local warnings = 0
  local errors = 0
  local hints = 0

  for _, diagnostic in ipairs(diagnostics) do
    if diagnostic.severity == vim.diagnostic.severity.WARN then
      warnings = warnings + 1
    elseif diagnostic.severity == vim.diagnostic.severity.ERROR then
      errors = errors + 1
    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
      hints = hints + 1
    end
  end

  local s = ""
  if warnings > 0 then
    s = s .. 'W:' .. warnings .. ' '
  end
  if errors > 0 then
    s = s .. 'E:' .. errors .. ' '
  end
  if hints > 0 then
    s = s .. 'H:' .. hints .. ' '
  end
  return s
end

-- local function filepath()
--   local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
--   if fpath == "" or fpath == "." then return " " end
--   return string.format("%%<%s/", fpath)
-- end

-- local function filename()
--   local fname = vim.fn.expand "%:t"
--   if fname == "" then return "" end
--   return string.format("%s ", fname)
-- end

-- TODO: actually add this..
local function get_search_count()
  return ''
end

---Returns attached LSP clients in `[name1, name2]` format or empty string,
---shortening the match 'language.server' to 'ls' to save space
---
---@return string
local function get_lsp_servers_attached()
    local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
    if #attached_clients == 0 then
        return ""
    end
    local it = vim.iter(attached_clients)
    it:map(function (client)
        local name = client.name:gsub("language.server", "ls")
        return name
    end)
    local names = it:totable()
    return "[" .. table.concat(names, ", ") .. "]"
end

-- vim.o.statusline = '  %{luaeval("Mode()")} │ %f%m %=│ %{luaeval("Dia()")}│ %{&filetype} │ %l:%c │ %03(%p%)%%  '

local function get_mode()
  -- see `:h mode()` for list
  local mode_map = {
    ['n']  = 'N',
    ['no'] = 'N',
    ['nov'] = 'N',
    ['noV'] = 'N',
    ['no\22'] = 'N',
    ['niI'] = 'I',
    ['niR'] = 'R',
    ['niV'] = 'R',
    ['nt'] = 'T', -- IDEA: terminal mode is pretty much insert mode
    ['v']  = 'V',
    ['V']  = 'VL',
    ['\22'] = 'VB',
    ['\22s'] = 'VB',
    ['s']  = 'S',
    ['S']  = 'SL',
    ['\19'] = 'SB',
    ['i']  = 'I',
    ['ic'] = 'I',
    ['ix'] = 'I',
    ['R']  = 'R',
    ['Rc']  = 'R',
    ['Rv'] = 'R',
    ['Rx'] = 'R',
    ['Rvc'] = 'R',
    ['Rvx'] = 'R',
    ['c']  = 'C',
    ['cr']  = 'C',
    ['cv']  = 'C',
    ['cvr']  = 'C',
    ['r']  = 'C',
    ['rm']  = 'C',
    ['r?']  = 'C',
    ['!']  = 'C',
    ['t']  = 'T'
  }
  local mode = vim.api.nvim_get_mode().mode
  return string.format(' %s ', mode_map[mode] or '')
end

---@return string stl-format string to use with `:h 'stl`
function M.statusline()
  local divider = '│'

  return table.concat({
    get_mode(),                             -- I|N|O|R|V|C|S|T mode indicator (coarse)
    divider,
    '%t',                                   -- filename.lua
    ' %(%M %R %H%)',                        -- + RO HLP
    get_lsp_diagnostics(),                  -- W:2 E:3
    get_recording_register(),               -- recording @ q
    '%=',                                   -- right-align
    get_search_count(),                     -- [1/4]
    ' %S ',                                 -- partial commands, use `set sloc=statusline`
    get_lsp_servers_attached(),             -- [pyls, pyright]
    divider,
    '%10.(%l:%c%V%) ',                          -- 75,22-32 or empty
    divider,
    ' %P '                                   -- Top|Bot|All|23%
  })
end

---@return string stl-format string to use with `:h 'tabline`
function M.tabline()
end

return M
