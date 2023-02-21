local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = { "rust", "lua", "solidity", "javascript", "typescript" },
  -- highlight = {
  --   enable = true,
  -- },
  -- indent = {
  --   enable = true,
  -- },
  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "gnn",
  --     node_incremental = "grn",
  --     scope_incremental = "grc",
  --     node_decremental = "grm",
  --   },
  -- },
  -- textobjects = {
  --   move = {
  --     enable = true,
  --     set_jumps = true,
  --     goto_next_start = {
  --       ["]m"] = "@function.outer",
  --       ["]]"] = "@class.outer",
  --     },
  --     goto_next_end = {
  --       ["]M"] = "@function.outer",
  --       ["]["] = "@class.outer",
  --     },
  --     goto_previous_start = {
  --       ["[m"] = "@function.outer",
  --       ["[["] = "@class.outer",
  --     },
  --     goto_previous_end = {
  --       ["[M"] = "@function.outer",
  --       ["[]"] = "@class.outer",
  --     },
  --   },
  -- },
})
