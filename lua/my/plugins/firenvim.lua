vim.g.firenvim_config = {
  globalSettings = {
    alt = 'all',
    cmdlineTimeout = 3000,
  },
  -- keys are JS-regex pattern against full URL, `priority` is tiebreaker on multiple matches
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
