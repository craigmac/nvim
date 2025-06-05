local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out =
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
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

require('lazy').setup({
  spec = {
    -- import all LazySpecs from lua/plugins/*.lua
    { import = 'plugins' },
  },
  install = { colorscheme = { 'default' } },
  defaults = {
    -- to turn ON spec in either vscode/firenvim just set local spec `cond = true`
    cond = not vim.g.vscode and not vim.g.firenvim,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  rocks = {
    enabled = true,
    hererocks = true,
  },
  dev = {
    path = '~/src',
    patterns = { 'craigmac' }, -- use local dev.path if spec name contains these
    fallback = true, -- use git repo if local not found
  },
  ui = {
    size = { width = 0.9, height = 0.9 },
    border = 'rounded',
    wrap = false,
  },
})
