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
---  as an stl-format string. just always use %{% %} and forget about it, like nmap vs nnoremap.
---@return string # `:help 'stl` format string
function M.StatusLine()
  local stl_parts = {
    -- example: ` I|N|C|R|V|B |` replacing ^V (two chars) with B for visual (B)lock
    "%( %{% toupper(mode() == '' ? 'b' : printf('%s │', mode())) %}%)",
    -- example: ` main |` if gitsigns installed and loaded
    "%( %{% exists('b:gitsigns_head') ? b:gitsigns_head .. ' │' : '' %}%)",
    -- example: `<ua\foo\bar\main.lua` shorten lefthand side when not enough room
    "%<%f",
    -- add modified symbol if buffer modified - ignore `:term` buffers which report as modified
    "%( %{% &modified && &buftype != 'terminal' ? '±' : '' %}%)",
    -- not (!) modifiable - again, ignore what a `:term` buffer reports
    "%( %{% !&modifiable && &buftype != 'terminal' ? '!±' : '' %}%)",
    -- readonly - unsure on difference from `set nomodifiable`
    "%( %{% &readonly ? '[RO]' : '' %}%)",
    -- example: ` [Preview Window]` builtin %W gives ',PRV' and %w gives '[Preview]'
    "%( %{% &previewwindow ? '[Preview Window]' : '' %}%)",
    -- example: ` (1 of 3)` current position in args list, non-empty %a always leads with one space
    "%(%a%)",
    -- example: ` ⌕ 1/1000` show current search match position of total search matches
    "%( %{% v:hlsearch ? printf('⌕ %s/%s', searchcount().current, searchcount().total) : '' %}%)",
    "%=",
    -- example: ` @q` while recording to register 'q'
    "%( %{% reg_recording() != '' ? printf('@%s', reg_recording()) : '' %}%)",
    -- examples:
    -- partial cmd (waiting):    ` di`
    -- visual selection example: ` 1`
    -- visual block example:     ` 12x34`
    "%( %{% &showcmdloc == 'statusline' ? '%S' : '' %}%)",
    -- example: ` <hangul>` when `:h :lmap` is active
    "%( %{% exists('b:keymap_name') ? printf('<%s>', b:keymap_name) : '' %}%)",
    -- example: ` ◐ ` if busy is set by e.g., LSP server signals busy
    "%( %{% &busy ? '◐' : '' %}%)",
    -- example: ` E:2 W:3 I:4 H:5` if diagnostic E/W/I/H using default symbols
    "%( %{% v:lua.vim.diagnostic.status() %}%)",
    -- example: ` dos` if not utf-8 filencoding, show it
    "%( %{ &fenc != 'utf-8' ? &fenc : '' }%)",
    -- example: ` 123↕123 12→99` (14 char. aligned left, no max)
    "%-14.( %l↕%L %c→%{col('$')-1}%)",
    -- examples: ` 0%` | ` 19%` | ` 100%`
    "%( %p%%%)",
    -- example: ` help ` relying on this instead of %H help flag
    "%( %{% &filetype %} %)"
  }
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
