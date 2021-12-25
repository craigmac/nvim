local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path,
  }
  print "Installing packer.nvim, close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- pcall() won't error out if it doesn't exist
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  use { 'wbthomason/packer.nvim', lock = true, }
  use { 
    'nvim-telescope/telescope.nvim', 
    lock = true,
    requires = { {'nvim-lua/plenary.nvim', lock = true} }
  }
  use { 
    'nvim-telescope/telescope-fzf-native.nvim',
    lock = true,
    run = 'make',
  }

  use { 'numToStr/Comment.nvim', lock = true }
  use { 
    'JoosepAlviste/nvim-ts-context-commentstring', 
    lock = true,
    after = { 'nvim-treesitter' }
  }
  use { 'nvim-treesitter/nvim-treesitter', lock = true, run = ':TSUpdate' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects',
    lock = true,
    after = { 'nvim-treesitter' },
  }

  use { 'neovim/nvim-lspconfig', lock = true }
  use { 'jose-elias-alvarez/null-ls.nvim', lock = true }
  use { 'b0o/SchemaStore.nvim', lock = true, after = { 'nvim-lspconfig' }}
  use { 'hrsh7th/nvim-cmp', lock = true }
  use { 'hrsh7th/cmp-nvim-lsp', lock = true, after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-buffer', lock = true, after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-path', lock = true, after = 'nvim-cmp' }
  use { 'hrsh7th/cmp-cmdline', lock = true, after = 'nvim-cmp' }
  use { 'saadparwaiz1/cmp_luasnip', lock = true, after = 'nvim-cmp' }
  use { 'L3MON4D3/LuaSnip', lock = true, after = 'nvim-cmp' }
  use { 'rafamadriz/friendly-snippets', lock = true, after = 'LuaSnip' }
  use { 'tpope/vim-fugitive', lock = true }
  use { 'tpope/vim-rhubarb', lock = true, after = 'vim-fugitive' }
  use { 'lewis6991/gitsigns.nvim', lock = true }

  use { 'projekt0n/github-nvim-theme', lock = true }
  use { 'mcchrish/zenbones.nvim', lock = true, requires = { {'rktjmp/lush.nvim', lock = true} }}
  use { 'tomasiser/vim-code-dark', lock = true }

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

