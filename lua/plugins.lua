require("packer").startup(function(use)
	-- package manager
	use("wbthomason/packer.nvim")

	-- theme
	use("gruvbox-community/gruvbox")

	use({
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				default = true,
			})
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("plugins.lualine")
		end,
	})

	-- code completion
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.nvim-lspconfig")
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("plugins.nvim-cmp")
		end,
	})

	-- rust
	use({
		"simrat39/rust-tools.nvim",
		config = function()
			require("plugins.rust-tools")
		end,
	})

	use({
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.crates")
		end,
	})

	-- autoformat
	use({
		"stevearc/conform.nvim",
		config = function()
			require("plugins.conform")
		end,
	})

	-- diagnostics
	use({
		"mfussenegger/nvim-lint",
		config = function()
			require("plugins.nvim-lint")
		end,
	})

	use({
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.trouble")
		end,
	})

	-- emmet
	use("mattn/emmet-vim")

	-- copilot
	use("github/copilot.vim")

	-- treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("plugins.treesitter")
		end,
	})

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.x",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.telescope")
		end,
	})

	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
	})

	use({
		"nvim-telescope/telescope-frecency.nvim",
		requires = { "tami5/sqlite.lua" },
	})

	-- nvim-tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins.nvim-tree")
		end,
	})

	-- startup screen
	use({
		"goolord/alpha-nvim",
		config = function()
			require("plugins.alpha")
		end,
	})

	-- git
	use({ "tpope/vim-fugitive" })

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.gitsigns")
		end,
	})

	-- utils
	use({
		"Pocco81/true-zen.nvim",
		config = function()
			require("true-zen").setup()
		end,
	})

	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient").enable_profile()
		end,
	})

	-- editing
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use("simnalamburt/vim-mundo")

	use("chaoren/vim-wordmotion")

	use({
		"tpope/vim-surround",
		requires = {
			"tpope/vim-repeat",
		},
	})

	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	})

	use({
		"Shatur/neovim-session-manager",
		config = function()
			require("session_manager").setup({
				autoload_mode = "Disabled",
				autosave_last_session = false,
			})
		end,
	})

	-- tmux
	use("christoomey/vim-tmux-navigator")
end)
