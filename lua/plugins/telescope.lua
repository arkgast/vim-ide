local telescope = require("telescope")

local actions = require("telescope.actions")

telescope.load_extension("frecency")
telescope.load_extension("fzf")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Esc>"] = actions.close,
      },
    },
    layout_strategy = "vertical",
    layout_config = { width = 0.90, height = 0.90 },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    frecency = {
      db_root = os.getenv("HOME") .. "/.config/nvim/frencency_db",
      show_scores = true,
      ignore_patterns = {
        "*.git/*",
        -- javascript
        "node_modules/*",
        -- java
        "target/*",
        -- csharp
        "obj/*",
        "bin/*",
      },
      workspaces = {
        ["minka"] = os.getenv("HOME") .. "/Projects/Minka/minka_",
        ["config"] = os.getenv("HOME") .. "/Projects/Vim/vim-ide",
        ["veloud"] = os.getenv("HOME") .. "/Projects/Veloud/tefia_",
      },
    },
  },
})
