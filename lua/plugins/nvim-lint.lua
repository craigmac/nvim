-- https://github.com/mfussenegger/nvim-lint
return {
  -- https://lazy.folke.io/spec
  'mfussenegger/nvim-lint',
  event = { 'BufWritePre' },
  enabled = true, -- false triggers uninstall, `cond = false` doesn't
  -- opts = {},
}

