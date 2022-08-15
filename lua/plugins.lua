require("packer").startup(function(use)
  -- package manager
  use("wbthomason/packer.nvim")

  -- theme
  use("gruvbox-community/gruvbox")

  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("plugins.lualine")
    end,
  })

  -- code completion
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require('plugins.nvim-lspconfig')
    end
  })

  use ({
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.nvim-cmp')
    end,
  })

  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp-signature-help")
  use("hrsh7th/cmp-nvim-lsp-document-symbol")
  use("saadparwaiz1/cmp_luasnip")
  use("L3MON4D3/LuaSnip")
  use("rafamadriz/friendly-snippets")

  use("onsails/lspkind.nvim")

  -- use({
  --   "jose-elias-alvarez/null-ls.nvim",
  --   config = function()
  --     require("plugins.nls")
  --   end,
  -- })

  -- fuzzy finder
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  })

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
end)
