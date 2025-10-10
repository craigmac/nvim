local M = {}

---@param n integer tabpage number to create label for
---@return string # label for tabpage `n`
function M.TabLabel(n)
  local buflist = vim.fn.tabpagebuflist(n)
  local winnr = vim.fn.tabpagewinnr(n)
  local bufname = vim.fn.bufname(buflist[winnr])
  local isdir = bufname:sub(#bufname) == '/'
  local name = vim.fn.fnamemodify(bufname, isdir and ':h:t' or ':t') .. (isdir and '/' or '')
  name = name:len() > 20 and name:sub(1, 20) .. '…' or name
  return name == '' and 'No Name' or name
end

---@return string # stl-format string
function M.TabLine()
  local s = {}
  for i = 1, vim.fn.tabpagenr('$') do
    local active_tab = i == vim.fn.tabpagenr()
    local hlgroup = active_tab and '%#TabLineSel#' or '%#TabLine#'

    vim.list_extend(s, {
      hlgroup,
      (' %%%dT'):format(i),
      tostring(i),
      (' %%{v:lua.M.TabLabel(%d)}'):format(i),
      '%T ',
    })
  end
  -- After last tabpage: Fill with TabLineFill highlight
  vim.list_extend(s, { '%#TabLineFill#' })
  return table.concat(s)
end

---@return string # `:help 'stl` format string
function M.StatusLine()
  -- default in 0.12 (its long so not in `:h 'stl`) it's in src/nvim/options.lua is neovim git repo
  --   '%<',
  --   '%f %h%w%m%r ',
  --   '%=',
  --   "%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}",
  --   "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}",
  --   "%{% &busy > 0 ? '◐ ' : '' %}",
  --   "%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)",
  --   "%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}",
  local parts = {
    '%<',
    '%f ',
    '%(%h%w%m%r %)',
    '%3p%% « %l/%L|%v ',
    "%{% reg_recording() == '' ? '' : '%#DiffAdd#@'..reg_recording()..'%* ' %}",
    "%{% &showcmdloc == 'statusline' ? '%(%S «%)' : '' %}",
    "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}",
    "%{% &busy > 0 ? '◐ ' : '' %}",
    -- working:
    "%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)",
    -- experiment with [[ ... ]] syntax: did not work!
    -- "%(%{luaeval([[(package.loaded['vim.diagnostic'] and vim.diagnostic.status()) or '' ]])} %)",
    --
    -- if ruler is off use empty string, if it's on: is rulerformat empty? use default value - else use rulerformat
    -- "%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}",
  }
  return table.concat(parts)
end

---https://github.com/neovim/neovim/pull/34545
---
---Evaluated when searching for file names using the `:find` command
---@return string[] results Array of files found
function M.FindFunc(name)
  local search_pattern = name or '.'
  local cmd = vim.list_extend({
    'rg',
    '--files',
    '--color',
    'never',
    '--glob',
    search_pattern,
  }, vim.opt.path:get())
  local res = vim.system(cmd, { text = true }):wait()
  return vim.split(res.stdout or '', '\n', { trimempty = true })
end

return M
