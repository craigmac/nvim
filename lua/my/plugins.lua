local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Bootstrapping packer.nvim... close and reopen Neovim.")
	vim.cmd([[ packadd packer.nvim ]])
end

-- Source and re-sync when we save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]])

require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })
	use({ "neovim/nvim-lspconfig" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-path" })
	use("tpope/vim-surround")
	use({ "tpope/vim-repeat", after = "vim-surround" })
	use("tpope/vim-fugitive")
	use({ "tpope/vim-rhubarb", after = "vim-fugitive" })
	-- TODO: add fix for C-k in LSP buffers
	use("craigmac/vim-tmux-navigator") -- my fork with neovim fix for <C-l>
	use({ "mcchrish/zenbones.nvim", requires = "rktjmp/lush.nvim" })
	use("projekt0n/github-nvim-theme")
	use("nvim-lualine/lualine.nvim")
	use("lewis6991/gitsigns.nvim")

	-- if we need to bootstrap because packer wasn't installed, do it
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
