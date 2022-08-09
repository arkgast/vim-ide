local telescope = require("telescope")

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },
  },
  extensions = {
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
