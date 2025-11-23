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

---Returns an stl-format string to use with `:h 'statusline`
---
---The nvim default value is not in docs because it's so long, you can find it in the
---nvim repo source file:  `src/nvim/options.lua`
---
---Wrapping an expression with `%( %{%` and `%}%)` will:
---* prepend one leading space to the expression result, BUT
---* only if result is not empty string/whitespace.
---* when it is empty string/whitespace the entire group contained in %( %) does not take up any space
---* using `%{ ... }` for an expr is simpler, but if the expr returns %f it isn't re-evaluated
---  as an stl-format string. just always use %{% %} and forget about it
---@return string # `:help 'stl` format string
function M.StatusLine()
  -- stylua: ignore start
  local stl_parts = {
    "%( %{% toupper(mode() == '' ? 'b' : mode()) .. ' │'              %}%)",
    "%( %{% exists('b:gitsigns_head') ? b:gitsigns_head .. ' │' : ''    %}%)",
    "%( %<%f%)",
    "%( %{% &modified && &buftype != 'terminal' ? '±' : ''              %}%)",
    "%( %{% !&modifiable && &buftype != 'terminal' ? '!±' : ''          %}%)",
    "%( %{% &readonly ? '[RO]' : ''                                     %}%)",
    "%( %{% &previewwindow ? '[Preview Window]' : ''                    %}%)",
    "%( %a%)",
    "%( %{% v:hlsearch ? printf('%s/%s', searchcount().current, searchcount().total) : '' %}%)",
    "%=",
    "%( %{% reg_recording() != '' ? printf('@%s', reg_recording()) : '' %}%)",
    "%( %{% &showcmdloc == 'statusline' ? '%S' : ''                     %}%)",
    "%( %{% exists('b:keymap_name') ? '<' .. b:keymap_name .. '>' : ''  %}%)",
    "%( %{% &busy ? '◐' : ''                                            %}%)",
    "%( %{% v:lua.vim.diagnostic.status()                               %}%)",
    "%( %{% &fenc != 'utf-8' ? &fenc : ''                               %}%)",
    -- thousands separated numbers for humans: 1134485 becomes 1,134,485
    -- '%{substitute(v:lnum,"\\d\\zs\\ze\\' .. '%(\\d\\d\\d\\)\\+$",",","g")}'
    "%-14.( %l↕%L %v→%{% virtcol('$') - 1                               %}%)",
    "%( %p%%%)",
    "%( %{% &filetype .. ' '                                            %}%)",
  }
  -- stylua: ignore end
  return table.concat(stl_parts)
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
