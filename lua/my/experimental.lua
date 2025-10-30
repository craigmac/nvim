--[[
`0` cmdheight will hide the following information:
1. partially entered commands shown by default with `set showcmdloc=last`
   solution:
   * default &stl conditionally shows it if showcmdloc is set to 'statusline'
   * also added to conditional to also show if cmdheight is 0
2. indication of macro recording like `recording @q`
   solutions:
   * conditionally show in &stl somewhere
3. modes shown by `&showmode` like `-- FOO --` where FOO is INSERT|VISUAL|VISUAL BLOCK|REPLACE
   solutions:
   * show at head of &stl using capital letters like 'N|I|V|^V|R'
4. search count like `W [1/4]`
   solutions:
   * conditionally show search count, e.g., `W [1/4]` somewhere in &stl
--]]
vim.o.cmdheight = 0

--[[
default in 0.12 (its long so not shown in `:h 'stl`). Found in `src/nvim/options.lua` of nvim repo.
local default_stl = table.concat({
  '%<',
  '%f %h%w%m%r ',
  '%=',
  "%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}",
  "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}",
  "%{% &busy > 0 ? '◐ ' : '' %}",
  "%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)",
  "%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}",
})
--]]

vim.o.statusline = table.concat({
  -- visual block is '^V' but we want one character so make it 'B'
  ' %{% toupper(mode() == "" ? "b": mode()) %} ',
  '│ ',
  '%<',
  -- free up the space taken if none of the modifiers are set and set max width for filename
  '%.50f %(%h%w%m%r%) ',
  '%=',
  -- reduce left-aligned 10 cell wide minimum and add case to show if cmdheight is set to 0
  "%{% (&showcmdloc == 'statusline') || (&cmdheight == 0) ? '%-5.S ' : '' %}",
  "%{ exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' }",
  -- simplify the default
  "%{ &busy ? '◐ ' : '' }",
  "%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)",
  "%{% &ruler ? ( &rulerformat == '' ? '%-17.(%l/%L | %c/%{col(''$'')-1}%) %P' : &rulerformat ) : '' %}",
})

-- vim.o.statusline = table.concat({
--   ' %{% toupper(mode()) %} │ ',
--   '%<',
--   '%f ',
--   '%(%h%w%m%r %)',
--   '%3p%% « %l/%L|%v ',
--   "%{% reg_recording() == '' ? '' : '%#DiagnosticError#@'..reg_recording()..'%* ' %}",
--   "%{% &showcmdloc == 'statusline' ? '%(%S «%)' : '' %}",
--   "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}",
--   "%{% &busy > 0 ? '◐ ' : '' %}",
--   -- working:
--   "%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)",
-- })

-- modules
vim.loader.enable()

require 'vim._extui'.enable {
  enable = true,
  msg = {
    target = 'msg',
    timeout = 4000
  }
}

-- `3` value for laststatus requires carefully thought out winbar value
-- vim.o.laststatus = 3

