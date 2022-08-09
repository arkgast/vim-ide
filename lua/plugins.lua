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
  use("neovim/nvim-lspconfig")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("saadparwaiz1/cmp_luasnip")
  use("L3MON4D3/LuaSnip")

  use({
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("plugins.nls")
    end,
  })

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
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  })

  -- git
  use({
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = function()
      require("plugins.neogit")
    end,
  })

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
