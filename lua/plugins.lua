require('packer').startup(function(use)
  -- package manager
	use 'wbthomason/packer.nvim'

  -- theme
	use 'gruvbox-community/gruvbox'

  -- completion
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

	use {
		'w0rp/ale',
		ft = {'sh', 'zsh', 'javascript', 'typescript', 'lua'},
		cmd = 'ALEEnable',
		config = 'vim.cmd[[ALEEnable]]'
	}

  -- finder
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

  -- tree
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  }

  -- startup screen
  use {
    'goolord/alpha-nvim',
    config = function ()
      require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }

  -- utils
  use "Pocco81/true-zen.nvim"

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use 'chaoren/vim-wordmotion'
  
  use 'tpope/vim-surround'

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

end)
