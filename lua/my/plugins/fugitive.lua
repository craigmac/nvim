return {
  'tpope/vim-fugitive',
  -- needs to load right away for {ftdetect,syntax,ftplugin,plugin,syntax}/*.vim
  lazy = false,
  cond = (not vim.g.vscode) and (not vim.g.firenvim),
  config = function()
    vim.keymap.set('n', '<Leader>gg', '<Cmd>G<CR>', { desc = 'Git summary window' })
    vim.keymap.set('n', '<Leader>gP', '<Cmd>G! push<CR>', { desc = 'Git push async' })
    vim.keymap.set('n', '<Leader>gb', '<Cmd>G blame %<CR>', { desc = 'Git blame buffer' })
    vim.keymap.set('n', '<Leader>gl', '<Cmd>G log %<CR>', { desc = 'Git log of current buffer' })

    vim.api.nvim_create_autocmd('User', {
        pattern = 'FugitiveIndex',
        desc = 'Ran when fugitive-summary buffer is loaded.',
        group = augroup,
        callback = function()
            vim.cmd([[norm gU]])
          end,
        })
  end,
}
