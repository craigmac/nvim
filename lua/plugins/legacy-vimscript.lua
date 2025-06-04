-- Various tpope and other legacy vim script plugins
-- https://github.com/tpope/vim-unimpaired
---@type LazySpec[]
return {
  {
    'tpope/vim-unimpaired',
    dependencies = 'tpope/vim-repeat',
    event = 'VeryLazy',
  },
  {
    'tpope/vim-dispatch',
    event = 'VeryLazy',
  },
  {
    'mbbill/undotree',
    keys = { '<leader>U', '<Cmd>UndotreeToggle<CR>' },
  },
}
