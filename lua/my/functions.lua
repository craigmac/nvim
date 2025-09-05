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
  local parts = {
    -- ex: ` @ ~/.config/nvim/lua/my `
    '@ ',
    '%{fnamemodify(getcwd(0), ":~")}',
    -- ex: ` W:1 H:3 E:5 ` native API only works in 0.12
    -- '%(%{ v:lua.vim.diagnostics.get() }%)',
    '%=',
    -- ex: `[rec "w] ` using `:hi User1` if recording, otherwise empty
    '%{% reg_recording() == "" ? "" : "%1*[rec \\""..reg_recording().."]%*" %}',
    -- ex: ` da …` using `:hi User4` if &sloc == 'statusline' otherwise empty
    '%{% &showcmdloc == "statusline" ? "%( %4*%S … %*%)" : "" %}',
    -- ex: ` #9–112:85 │ ` 
    '%( #%l–%L:%v%)',
    -- ex: `python │ ` if no filetype, empty string, otherwise max len of 10 chars 
    '%.10( %{&filetype}%)',
    -- ex: `Top|Bot|68%`
    ' %P',
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
