local telescope = require("telescope")

local actions = require("telescope.actions")

telescope.load_extension("fzf")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<Esc>"] = actions.close, -- Keep this to ensure Telescope closes with Esc
        ["<CR>"] = actions.select_tab,
        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
        ["<C-x>"] = actions.select_horizontal, -- split horizontally
        ["<C-v>"] = actions.select_vertical,   -- split vertically
        ["<C-l>"] = actions.complete_tag,      -- complete tag
        ["<C-/>"] = actions.which_key,         -- which key help
      },
    },
    layout_strategy = "vertical",
    layout_config = { width = 0.90, height = 0.90 },
    sorting_strategy = "ascending",
    file_ignore_patterns = {
      "node_modules/*",
      "target/*",
      "obj/*",
      -- "bin/*",
      "undodir/*",
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = false,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
})
