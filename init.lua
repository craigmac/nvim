-- nvim nightly config

vim.loader.enable()

-- determining bg etc. via termresponse can take non-nil time
-- vim.defer_fn(function() require('my.colors') end, 250)

-- set up cb now in case added packages need something run on install
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if name == 'nvim-treesitter' and kind == 'update' then
      vim.cmd('TSUpdate')
    elseif name == 'firenvim' and (kind == 'install' or kind == 'update') then
      vim.fn['firenvim#install'](0)
    end
  end,
  desc = "Callback ran after vim.pack.add() changed a plugin's state.",
  group = vim.api.nvim_create_augroup('my.augroup.pack', {})
})

local pkg_specs = {
  {
    -- `:Lsp*` and runtime `lsp/*` (vim.lsp.Config) settings
    src = 'https://github.com/neovim/nvim-lspconfig'
  },
  {
    -- install and manage LSP, formatters, linters and handle PATH integration
    src = 'https://github.com/mason-org/mason.nvim'
  },
  {
    -- `:TS*` and runtime `queries/*` files (indents/highlights/injections)
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main'
  },
  {
    -- treesitter improved ]], ]m, et al., and add ic/ac, if/af, and more
    src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    version = 'main'
  },
  {
    src = 'https://github.com/ibhagwan/fzf-lua'
  },
  {
    src = 'https://github.com/mrjones2014/smart-splits.nvim'
  },
  {
    src = 'https://github.com/kylechui/nvim-surround'
  },
  {
    src = 'https://github.com/glacambre/firenvim'
  },
  {
    -- toggle with `yog`, <Leader>c + p/s/S/r/R, [c, ]c 
    src = 'https://github.com/lewis6991/gitsigns.nvim'
  },
}
vim.pack.add(pkg_specs)
