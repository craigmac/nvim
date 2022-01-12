vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup END
]])

require("packer").startup(function(use)
	-- Basics
	use({ "wbthomason/packer.nvim" })
	use({ "numToStr/Comment.nvim" })
	use("tpope/vim-surround")
	use({ "tpope/vim-repeat", after = "vim-surround" })

	-- Telescope related
	use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-telescope/telescope-ui-select.nvim")
	use("nvim-telescope/telescope-github.nvim")

	-- Treesitter and related
	use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
	use({ "neovim/nvim-lspconfig" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-path" })
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")

	-- Git-related
	use("tpope/vim-fugitive")
	use({ "tpope/vim-rhubarb", after = "vim-fugitive" })
	use("lewis6991/gitsigns.nvim")

	-- UI
	use("projekt0n/github-nvim-theme")
	use("nvim-lualine/lualine.nvim")
	use("lukas-reineke/indent-blankline.nvim")
end)
