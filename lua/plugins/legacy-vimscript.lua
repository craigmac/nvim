-- Various tpope and other legacy vim script plugins
-- https://github.com/tpope/vim-unimpaired
---@module 'lazy'
---@type LazyPluginSpec[]
return {
  {
    'tpope/vim-unimpaired',
    dependencies = 'tpope/vim-repeat',
    event = 'VeryLazy',
  },
  {
    -- m<CR> for :Make
    -- `<CR> for :Dispatch
    -- '<CR> for :Start
    -- g'<CR> for :Spawn (same as Start but always make new process don't reuse existing)
    -- m|`|'|g' then <Space> allows you to give args, like '<Space>lazygit
    'tpope/vim-dispatch',
    event = 'VeryLazy',
  },
  {
    -- <C-a>, <C-e>, <C-d>, et al., readline bindings in Cmdline and insert mode
    'tpope/vim-rsi'
  },
  {
    'mbbill/undotree',
    config = function()
      -- plugin/undotree.vim required to be sourced for this to work
      vim.keymap.set('n', '<Leader>U', vim.cmd.UndotreeToggle)
    end
  },
}
