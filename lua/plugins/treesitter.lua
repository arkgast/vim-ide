local configs = require("nvim-treesitter.configs")

configs.setup({
  -- Parsers
  ensure_installed = {
    "rust",
    "lua",
    "solidity",
    "javascript",
    "typescript",
    "tsx",
    "go",
    "python",
    "c",
    "cpp",
    "c_sharp",
    "html",
    "css",
    "scss",
    "json",
    "yaml",
    "toml",
    "markdown",
    "markdown_inline",
    "vim",
    "vimdoc",
    "query",
    "bash",
    "regex",
    "gitignore",
    "diff",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  modules = {},

  -- Highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    -- Disable for large files
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },

  -- Indentation
  indent = {
    enable = true,
    disable = { "python" }, -- Python indentation is better with built-in
  },

  -- Incremental Selection
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
  },

  -- Text Objects
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj
      keymaps = {
        -- Functions
        ["af"] = { query = "@function.outer", desc = "Select outer function" },
        ["if"] = { query = "@function.inner", desc = "Select inner function" },
        -- Classes
        ["ac"] = { query = "@class.outer", desc = "Select outer class" },
        ["ic"] = { query = "@class.inner", desc = "Select inner class" },
        -- Conditionals
        ["ai"] = { query = "@conditional.outer", desc = "Select outer conditional" },
        ["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },
        -- Loops
        ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
        ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
        -- Parameters
        ["aa"] = { query = "@parameter.outer", desc = "Select outer parameter" },
        ["ia"] = { query = "@parameter.inner", desc = "Select inner parameter" },
        -- Comments
        ["a/"] = { query = "@comment.outer", desc = "Select outer comment" },
        ["i/"] = { query = "@comment.inner", desc = "Select inner comment" },
        -- Blocks
        ["ab"] = { query = "@block.outer", desc = "Select outer block" },
        ["ib"] = { query = "@block.inner", desc = "Select inner block" },
        -- Calls
        ["aF"] = { query = "@call.outer", desc = "Select outer call" },
        ["iF"] = { query = "@call.inner", desc = "Select inner call" },
      },
      selection_modes = {
        ["@parameter.outer"] = "v", -- charwise
        ["@function.outer"] = "V", -- linewise
        ["@class.outer"] = "V", -- linewise
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ["<leader>sp"] = "@parameter.inner", -- swap parameters/arguments
        ["<leader>sf"] = "@function.outer", -- swap functions
      },
      swap_previous = {
        ["<leader>sP"] = "@parameter.inner",
        ["<leader>sF"] = "@function.outer",
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- Track movements in jumplist
      goto_next_start = {
        ["]f"] = { query = "@function.outer", desc = "Next function start" },
        ["]c"] = { query = "@class.outer", desc = "Next class start" },
        ["]a"] = { query = "@parameter.inner", desc = "Next parameter start" },
        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
      },
      goto_next_end = {
        ["]F"] = { query = "@function.outer", desc = "Next function end" },
        ["]C"] = { query = "@class.outer", desc = "Next class end" },
        ["]A"] = { query = "@parameter.inner", desc = "Next parameter end" },
        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
      },
      goto_previous_start = {
        ["[f"] = { query = "@function.outer", desc = "Previous function start" },
        ["[c"] = { query = "@class.outer", desc = "Previous class start" },
        ["[a"] = { query = "@parameter.inner", desc = "Previous parameter start" },
        ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
        ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
      },
      goto_previous_end = {
        ["[F"] = { query = "@function.outer", desc = "Previous function end" },
        ["[C"] = { query = "@class.outer", desc = "Previous class end" },
        ["[A"] = { query = "@parameter.inner", desc = "Previous parameter end" },
        ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
        ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
      },
      goto_next = {
        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
      },
      goto_previous = {
        ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
      },
    },

    lsp_interop = {
      enable = true,
      border = "rounded",
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>pf"] = { query = "@function.outer", desc = "Peek function definition" },
        ["<leader>pc"] = { query = "@class.outer", desc = "Peek class definition" },
      },
    },
  },

  -- Refactor Module
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
    highlight_current_scope = {
      enable = false, -- Can be distracting, enable if you like it
    },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
    navigation = {
      enable = true,
      keymaps = {
        goto_definition = "gnd",
        list_definitions = "gnD",
        list_definitions_toc = "gO",
        goto_next_usage = "]r",
        goto_previous_usage = "[r",
      },
    },
  },
})

-- Treesitter Context (shows function/class context at top)
require("treesitter-context").setup({
  enable = true,
  max_lines = 3, -- Maximum number of lines to show
  min_window_height = 20,
  line_numbers = true,
  multiline_threshold = 1,
  trim_scope = "outer",
  mode = "cursor",
  separator = nil,
  zindex = 20,
})

-- Auto-tag for HTML/JSX
require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
  per_filetype = {
    ["html"] = {
      enable_close = true,
    },
  },
})

-- Folding with Treesitter
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- Don't fold by default
vim.opt.foldlevel = 99
