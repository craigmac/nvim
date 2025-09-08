My = {} --  reserve a global table/namespace, view with `:=My`

vim.g.mapleader = ' '
vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

-- stops these $VIMRUNTIME/plugin files from completely loading (tiny impact on startup)
vim.g.loaded_gzip = 'any string should fail exists() test'
vim.g.loaded_zipPlugin = 'keep your bible quotes to yourself'
vim.g.loaded_remote_plugins = 'never use this'
vim.g.loaded_tarPlugin = 'nope I never browse .tar files'
vim.g.loaded_tutor_mode_plugin = 'no more :Tutor'

-- assembled from `highlight_group.c` in neovim source
vim.g.nvim_palette = {
  black          = '#07080d', -- same as 'gray1', added for alias
  red            = '#590008',
  green          = '#005523',
  yellow         = '#6b5300',
  blue           = '#004c73',
  magenta        = '#470045',
  cyan           = '#007373',
  white          = '#2c2e33', -- same as 'gray3', added as alias
  bright_black   = '#9b9ea4', -- same as 'gray4', added as alias
  bright_red     = '#ffc0b9',
  bright_green   = '#b3f6c0',
  bright_yellow  = '#fce094',
  bright_blue    = '#a6dbff',
  bright_magenta = '#ffcaff',
  bright_cyan    = '#8cf8f7',
  bright_white   = '#eef1f8', -- same as 'gray1', added as alias
  gray1          = '#07080d',
  gray2          = '#14161b', -- hl-Normal guibg in bg=dark, guifg in bg=light
  gray3          = '#2c2e33',
  gray4          = '#4f5258',
  bright_gray1   = '#eef1f8',
  bright_gray2   = '#e0e2ea', -- hl-Normal guibg in bg=light
  bright_gray3   = '#c4c6cd',
  bright_gray4   = '#9b9ea4',
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
      takeover = 'never',
    },
    ['https?://github.com/.*'] = {
      content = 'markdown',
      priority = 1,
      takeover = 'never',
    },
  },
}

