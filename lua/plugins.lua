local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- theme
  {
    "gruvbox-community/gruvbox",
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },

  -- code completion
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.nvim-lspconfig")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    requires = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("plugins.nvim-cmp")
    end,
  },

  -- c/c++
  {
    "p00f/clangd_extensions.nvim",
    config = function()
      require("clangd_extensions").setup({
        inline = true,
        only_current_line = true,
      })
    end,
  },

  -- rust (rust-tools is deprecated, using direct rust-analyzer config instead)
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.crates")
    end,
  },

  -- autoformat
  {
    "stevearc/conform.nvim",
    config = function()
      require("plugins.conform")
    end,
  },

  -- diagnostics
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("plugins.nvim-lint")
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.trouble")
    end,
  },

  -- debug
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    config = function()
      require("plugins.js-debug")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      require("plugins.nvim-dap-ui")
    end,
  },

  -- emmet
  "mattn/emmet-vim",

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.telescope")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  -- nvim-tree
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.nvim-tree")
    end,
  },

  -- startup screen
  {
    "goolord/alpha-nvim",
    config = function()
      require("plugins.alpha")
    end,
  },

  -- git
  "tpope/vim-fugitive",

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },

  -- utils
  {
    "Pocco81/true-zen.nvim",
    config = function()
      require("true-zen").setup()
    end,
  },

  {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient").enable_profile()
    end,
  },

  -- ai
  {
    "yetone/avante.nvim",
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("plugins.avante")
    end,
  },

  -- editing
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  "simnalamburt/vim-mundo",

  "chaoren/vim-wordmotion",

  {
    "tpope/vim-surround",
    requires = {
      "tpope/vim-repeat",
    },
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- tmux
  "christoomey/vim-tmux-navigator",
})
