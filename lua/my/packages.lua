vim.cmd.packadd('netrw')
vim.cmd.packadd('nohlsearch')

--   TODO:
--   * which? 'ggandor/leap.nvim' or 'folke/flash.nvim'
--   * oil.nvim instead of netrw
-- })

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.g.netrw_banner = 0
vim.g.netrw_hide = 0

require('lazy').setup({
  change_detection = {
    enabled = true,
    notify = false,
  },
  checker = {
    enabled = false,
    notify = false,
  },
  install = {
    colorscheme = {
      'default',
      'retrobox'
    }
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  spec = {
    {
      import = "my.plugins"
    },
  },
  ui = {
    -- use unicodes instead of relying on nerdfont
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
    size = {
      border = 'single',
      height = 0.8,
      width = 0.8,
    },
  },
})
