return {
  'glacambre/firenvim',
  build = ':call firenvim#build(0)',
  cond = vim.g.firenvim,
  init = function()
    vim.g.firenvim_config = {
      globalSettings = {
        alt = 'all',
        cmdlineTimeout = 3000,
      },
      localSettings = {
        ['.*'] = {
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
  end,
}
