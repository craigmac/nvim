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

-- default in 0.12 (its long so not in `:h 'stl`) it's in src/nvim/options.lua is neovim git repo
--   '%<',
--   '%f %h%w%m%r ',
--   '%=',
--   "%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}",
--   "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}",
--   "%{% &busy > 0 ? '◐ ' : '' %}",
--   "%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)",
--   "%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}",
---@return string # `:help 'stl` format string
function M.StatusLine()
  return table.concat({
    "%2{% toupper(mode()) %} │ ",
    "%(%{% exists('b:gitsigns_head') ? b:gitsigns_head .. ' │ ' : '' %}%)",
    "%f ",
    "%{% &modified ? '%3*●%* ' : '' %}",
    "%{% &readonly ? '%2*━%* ' : '' %}",
    -- minor flags, (h)elp, Previe(w) window, (a)rgs position (non-empty %a leads with one empty space)
    "%([%H%W]%)%a",
    -- search count, kept left to not confuse with %S (which will show '1' or '1x3' on selections)
    "%{% v:hlsearch ? printf(' ⌕ %s/%s ', searchcount().current, searchcount().total) : '' %}",
    '%=',
    "%2*%{% reg_recording() != '' ? printf('@%s ', reg_recording()) : '' %}%*",
    '%{% (&showcmdloc == "statusline") || (&cmdheight == 0) ? "%-5.S " : "" %}',
    '%(%{ exists("b:keymap_name") ? "<" .. b:keymap_name .. "> " : "" }%)',
    '%(%{ &busy ? "◐ " : "" }%)',
    -- example: `E:2 W:3 I:4 H:5`
    "%(%{ v:lua.vim.diagnostic.status() } %)",
    -- 1. no ruler?                                  => use ''
    -- 2. ruler is on:
    --    A. 'rulerformat' is set (default is '')    => use &rulerformat
    --    B. 'rulerformat' is not set (empty string) => use string we define
    "%{% !&ruler ? '' : !empty(&rulerformat) ? &rulerformat : '%-20.(▼ %l/%L ▶ %c/%{col(''$'')-1}%) %-4(%p%%%)' %}",
    -- if not utf-8 show encoding in red
    "%2*%{% &fenc != 'utf-8' ? &fenc : '' %}%*",
    " %(%{ &filetype } %)"
    })
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

-- Using builtin glob() example (vim script):
--[[
function! FindFuncGlob(cmdarg, cmdcomplete)
  let pat = a:cmdcomplete ? $'{a:cmdarg}*' : a:cmdarg
  return glob(pat, v:false, v:true)
endfunction
set findfunc=FindFuncGlob

-- Use the 'git ls-files' output
function FindGitFiles(cmdarg, cmdcomplete)
  let fnames = systemlist('git ls-files')
  return fnames->filter('v:val =~? a:cmdarg')
endfunction
set findfunc=FindGitFiles
--]]

return M
