-- global variables and functions
My = {}

vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

-- tells netrw to try fetching from this directory for missing dictionaries on `:h spell-SpellFileMissing`
vim.g.spellfile_URL = 'https://github.com/craigmac/en_CA/raw/refs/heads/main/spell'

-- otherwise $VIMRUNTIME/ftplugin/qf.vim will set one, and it doesn't play nice with laststatus=3 and winbar
vim.g.qf_disable_statusline = 1

-- assembled from `highlight_group.c` in neovim source
vim.g.nvim_palette = {
  black = '#07080d', -- same as 'gray1', added for alias
  red = '#590008',
  green = '#005523',
  yellow = '#6b5300',
  blue = '#004c73',
  magenta = '#470045',
  cyan = '#007373',
  white = '#2c2e33',        -- same as 'gray3', added as alias
  bright_black = '#9b9ea4', -- same as 'gray4', added as alias
  bright_red = '#ffc0b9',
  bright_green = '#b3f6c0',
  bright_yellow = '#fce094',
  bright_blue = '#a6dbff',
  bright_magenta = '#ffcaff',
  bright_cyan = '#8cf8f7',
  bright_white = '#eef1f8', -- same as 'gray1', added as alias
  gray1 = '#07080d',
  gray2 = '#14161b',        -- hl-Normal guibg in bg=dark, guifg in bg=light
  gray3 = '#2c2e33',
  gray4 = '#4f5258',
  bright_gray1 = '#eef1f8',
  bright_gray2 = '#e0e2ea', -- hl-Normal guibg in bg=light
  bright_gray3 = '#c4c6cd',
  bright_gray4 = '#9b9ea4',
}

-- when aligning with gl/gL reduces spaces to minimum required
vim.g.lion_squeeze_spaces = 1

-- <C-n>, <C-t>, and <C-w> must be unbound to be used for firenvim instead of browser,
-- on linux firefox you can't unbind these, but you can set alternatives in the extension
-- shortcuts to send them to firenvim using a different shortcuts, I use <A-t> <A-w> and <A-n>.
vim.g.firenvim_config = {
  globalSettings = {
    alt = 'all',
    -- hide `cmdline='firenvim'` after 3 seconds in we never get message to stop displaying it
    cmdlineTimeout = 3000,
  },
  -- js pattern against full URL, 'priority' is tiebreaker (higher wins) on multiple matches
  localSettings = {
    ['.*'] = {
      -- defaults for when there's no narrower pattern match against the URL
      cmdline = 'firenvim',
      content = 'text',
      priority = 0,
      -- https://github.com/glacambre/firenvim#configuring-what-elements-firenvim-should-appear-on
      selector = 'textarea:not([readonly], [aria-readonly]), div[role="textbox"]',
      takeover = 'never'
    },
    ['https?://github.com/.*'] = {
      content = 'markdown',
      priority = 1,
      takeover = 'always',
    },
  }
}

---@param value? number Minwid field value or 0 if no N specified
---@param mouse_clicks number How many mouse clicks - to detect double click if needed
---@param mouse_button string Mouse button used, typically l, r, and m but can be any lowercase ASCII
---@param mods string Modifiers pressed, contains s if shift, c for control, a for alt and m for meta
function My.ShowDiagnostics(value, mouse_clicks, mouse_button, mods)
  vim.diagnostic.open_float({ scope = 'buffer' })
end

---@return string # stl-format string
function My.Winbar()
  -- local bufnr = vim.fn.bufnr()
  return table.concat({
    '%=',
    -- string.format('(%d) ', bufnr),
    '%t',
    '%( [%M%R%H%W]%)',
    '%='
  })
end

---@param n number tabpage number to create label for
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

---@return string # `:help 'stl` format string
function My.StatusLine()
  local parts = {
    ' @ ',
    '%{fnamemodify(getcwd(0), ":~")}',
    ' │ ',
    '%(%{ v:lua.vim.diagnostic.status() }%)',
    '%=',
    '%{% reg_recording() == "" ? "" : "%1*[rec \\""..reg_recording().."]%* " %}',
    '%{% &showcmdloc == "statusline" ? "%(%4* %S … %*%)" : "" %}',
    ' %( #%l–%L:%v%)',
    ' │ ',
    '%.10(%{&filetype}%)',
    ' │ ',
    '%P ',
  }
  return table.concat(parts)
end

---https://github.com/neovim/neovim/pull/34545
---
---Evaluated when searching for file names using the `:find` command
function My.FindFunc(name)
  local search_pattern = name or '.'
  local cmd = vim.list_extend({
    'rg', '--files', '--color', 'never', '--glob', search_pattern
  }, vim.opt.path:get())
  local res = vim.system(cmd, { text = true }):wait()
  return vim.split(res.stdout, '\n', { trimempty = true })
end
