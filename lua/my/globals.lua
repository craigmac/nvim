-- global variables and functions
My = {}

vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

-- vim.g.loaded_netrwPlugin = 1
vim.g.loaded_2html = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_2html_plugin = 1

---@return string # stl-format string
function My.Winbar()
  -- local bufnr = vim.fn.bufnr()
  return table.concat({
    '%=',
    '%t',
    '%( [%M%R%H%W]%)',
    '%=',
  })
end

---@param n integer tabpage number to create label for
---@return string # label for tabpage `n`
function My.TabLabel(n)
  local buflist = vim.fn.tabpagebuflist(n)
  local winnr = vim.fn.tabpagewinnr(n)
  local bufname = vim.fn.bufname(buflist[winnr])
  local isdir = bufname:sub(#bufname) == '/'
  local name = vim.fn.fnamemodify(bufname, isdir and ':h:t' or ':t') .. (isdir and '/' or '')
  name = name:len() > 20 and name:sub(1, 20) .. '…' or name
  return name == '' and 'No Name' or name
end

---@return string # stl-format string
function My.TabLine()
  local s = {}
  for i = 1, vim.fn.tabpagenr('$') do
    local active_tab = i == vim.fn.tabpagenr()
    local hlgroup = active_tab and '%#TabLineSel#' or '%#TabLine#'

    vim.list_extend(s, {
      hlgroup,
      (' %%%dT'):format(i),
      tostring(i),
      (' %%{v:lua.My.TabLabel(%d)}'):format(i),
      '%T ',
    })
  end
  -- After last tabpage: Fill with TabLineFill highlight
  vim.list_extend(s, { '%#TabLineFill#' })
  return table.concat(s)
end
