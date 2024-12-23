local treesitter = require('nvim-treesitter.configs')

treesitter.setup({
  auto_install = true, -- install parsers if missing for every ft
  highlight = {
    enable = true,
    -- can also be function(lang, bufnr) that returns bool
    disable = { 'tmux' },
  },
  indent = { enable = true },
  folding = { enable = true },
  incremental_selection = {
    enable = true,
    -- TODO: this errors when in `q:`, small annoyance
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },
  -- requires 'nvim-treesitter/nvim-treesitter-textobjects' plugin
  textobjects = { enable = true },
})

