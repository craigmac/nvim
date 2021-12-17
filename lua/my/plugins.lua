local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer.nvim, close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Reloads Neovim when this file is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]]

-- pcall() won't error out if it doesn't exist
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Use popup window for packer
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- manage ourselves
  use "nvim-lua/popup.nvim" -- Neovim implementation of vim popup API, some plugins use it
  use "nvim-lua/plenary.nvim" -- Used by lots of plugins, useful Lua functions
  use "akinsho/toggleterm.nvim"
  use "nvim-telescope/telescope.nvim"
  use "numToStr/Comment.nvim" -- like vim-commentary but treesitter aware
  use "JoosepAlviste/nvim-ts-context-commentstring" -- used with Comment.nvim
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "nvim-treesitter/nvim-treesitter-textobjects"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
 -- wraps external formatters/linters to use builtin LSP stuff and act like a
 -- LSP server so we can leverage the builtin LSP stuff and use any
 -- formatter/linter we want, such as vale, markdownlint
  use "jose-elias-alvarez/null-ls.nvim"

  -- Completion framework and completion sources
  use "hrsh7th/nvim-cmp" -- Framework
  use "hrsh7th/cmp-nvim-lsp" -- LSP source
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline" -- vim command line source

  -- Snippets
  -- use "L3MON4D3/LuaSnip" -- Engine
  -- use "rafamadriz/friendly-snippets" -- some snippets
  -- use "saadparwaiz1/cmp_luasnip" -- luasnip source for nvim-cmp

  -- Git
  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"
  use "lewis6991/gitsigns.nvim"

  -- use "christoomey/vim-tmux-navigator"

  -- Colors
  use "projekt0n/github-nvim-theme"

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

