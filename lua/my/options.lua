-- global variables
vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0
-- from `highlight_group.c` in neovim source
vim.g.nvim_palette = {
  black = '#07080d', -- same as 'gray1', added for alias
  red = '#590008',
  green = '#005523',
  yellow = '#6b5300',
  blue = '#004c73',
  magenta = '#470045',
  cyan = '#007373',
  white = '#2c2e33', -- same as 'gray3', added as alias
  bright_black = '#9b9ea4', -- same as 'gray4', added as alias
  bright_red = '#ffc0b9',
  bright_green = '#b3f6c0',
  bright_yellow = '#fce094',
  bright_blue = '#a6dbff',
  bright_magenta = '#ffcaff',
  bright_cyan = '#8cf8f7',
  bright_white = '#eef1f8', -- same as 'gray1', added as alias
  gray1 = '#07080d',
  gray2 = '#14161b', -- hl-Normal guibg in bg=dark, guifg in bg=light
  gray3 = '#2c2e33',
  gray4 = '#4f5258',
  bright_gray1 = '#eef1f8',
  bright_gray2 = '#e0e2ea', -- hl-Normal guibg in bg=light
  bright_gray3 = '#c4c6cd',
  bright_gray4 = '#9b9ea4',
}

-- special characters and display
vim.o.fillchars = 'eob:⌁,diff: ,fold: ,foldclose:▶,foldopen:▼,lastline:⋯,msgsep:─,trunc:⋯,truncrl:⋯'
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-TermCursor'
vim.o.listchars = 'eol:↵,tab:⇥ ,trail:░,extends:»,precedes:«,nbsp:⍽'
vim.o.list = true
vim.o.winborder = 'single'
vim.o.foldtext = ''
vim.o.foldlevelstart = 99
vim.o.showmode = false

-- no wrap, but if we do enable wrap, use these wrap-related settings
vim.o.wrap = false
vim.o.breakindent = true
vim.o.joinspaces = false
vim.o.linebreak = true
vim.o.showbreak = '↳ '
vim.o.smoothscroll = true

-- searching/matching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.o.pumheight = 10
vim.o.shortmess = vim.o.shortmess
  .. table.concat({
    'c', -- no 'match 1 of 2' etc. messages when scrolling through completions
    's', -- no 'search hit BOTTOM...' messages and don't show 'W' for wrapped before [1/3]
    -- 'q', -- no 'recording @q' when recording macro
    -- 'S', -- no [1/5] search count shown
  })

---@param cmd_arg string The command argument to `:find`.
---@param cmd_completions boolean True when function being called to get cmdline matches for `:find` command.
---@return string[]|{} # The list of strings found or an empty list if nothing found/an error occurred.
function My.findfunc(cmd_arg, cmd_completions)
  -- not being called from command-line for results for `:h 'findfunc'`
  if not cmd_completions then
    vim.print('RgFiles() cmd_completions was false.')
    -- TODO: what do we want to do here then, just provide all files `rg --files` finds?
    return {}
  end
  -- being called as completion provider for `:find` on command-line
  vim.print('MyFindFunc() cmd_arg: ' .. cmd_arg)
  local pattern = cmd_completions and string.format('%s*', cmd_arg) or cmd_arg

  return { 'fileone', 'filetwo', 'filethree' }
end

vim.o.findfunc = 'v:lua.My.findfunc'

-- bars and lines
function My.diagnostic_status() return 'E: 1 W:2' end
vim.o.showcmdloc = 'statusline'
vim.o.signcolumn = 'yes'
-- https://github.com/neovim/neovim/issues/28809
vim.o.statusline = table.concat({
  '󰉋 ',
  '%{fnamemodify(getcwd(0), ":t")}',
  '%<',
  ' │ %.50(%t%)',
  '%( [%H%W%M%R]%)',
  '%=',
  '%{% &showcmdloc == "statusline" ? "%.10S" : "" %}',
  '%(%{v:lua.My.diagnostic_status()}%)',
  ' │ %(%l:%v%) ',
  ' │ %.10(%{&filetype}%)',
  ' │ %P ',
})

-- vim.o.showtabline = 2
-- function My.tabline ()
--   return table.concat({
--     '%{% tabpagenr() %}',
--     ' %t'
--   })
-- end
-- vim.o.tabline = '%!v:lua.My.tabline()'

-- editing
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = -1 -- use shiftwidth

-- startup/behaviour
vim.o.exrc = true
vim.o.secure = true
vim.o.diffopt = vim.o.diffopt .. ',followwrap,algorithm:minimal'
vim.o.jumpoptions = vim.o.jumpoptions .. ',view'
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.tabclose = 'uselast'
vim.o.undofile = true
-- shorter delay to trigger `:h vim.lsp.buf.document_highlight()`
vim.o.updatetime = 500
vim.o.wildcharm = tonumber(vim.keycode('<C-z>'))

-- menus, `:h popup-menu` and `$VIMRUNTIME/lua/vim/_defaults.lua`
vim.cmd.aunmenu({ args = { 'disable', 'PopUp.How-to\\ disable\\ mouse' } })

vim.cmd.anoremenu([[PopUp.Go\ to\ declaration\ [gd] <Cmd>lua vim.lsp.buf.declaration()<CR>]])
vim.cmd.anoremenu([[PopUp.Go\ to\ source\ implementation\ [gri] <Cmd>lua vim.lsp.buf.implementation()<CR>]])
vim.cmd.anoremenu([[PopUp.Go\ to\ type\ definition\ [grt] <Cmd>lua vim.lsp.buf.type_definition()<CR>]])
vim.cmd.anoremenu([[PopUp.Go\ to\ references\ [grr] <Cmd>lua vim.lsp.buf.references()<CR>]])
vim.cmd.anoremenu([[PopUp.Code\ actions\ [gra] <Cmd>lua vim.lsp.buf.code_action()<CR>]])
vim.cmd.anoremenu([[PopUp.Rename\ symbol\ [grn] <Cmd>lua vim.lsp.buf.rename()<CR>]])
vim.cmd.anoremenu([[PopUp.Document\ symbol\ [gO] <Cmd>lua vim.lsp.buf.document_symbol()<CR>]])
vim.cmd.anoremenu([[PopUp.Workspace\ symbol\ [grO] <Cmd>lua vim.lsp.buf.workspace_symbol()<CR>]])
vim.cmd.anoremenu([[PopUp.Show\ incoming\ calls\ [g(] <Cmd>lua vim.lsp.buf.incoming_calls()<CR>]])
vim.cmd.anoremenu([[PopUp.Show\ outgoing\ calls\ [g)] <Cmd>lua vim.lsp.buf.outgoing_calls()<CR>]])
vim.cmd.anoremenu([[PopUp.Format\ buffer <Cmd>lua vim.lsp.buf.format()<CR>]])
vim.cmd.anoremenu(
  [[PopUp.Toggle\ inlay-hints\ [yoh] <Cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>]]
)
