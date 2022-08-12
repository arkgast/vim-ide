require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  view = {
    number = true,
    relativenumber = true,
    width = 35,
    side = "left",
    mappings = {
      list = {
        { key = "C", action = "copy" },
        { key = "P", action = "paste" },
        { key = "c", action = "close_node" },
        { key = "p", action = "parent_node" },
        { key = "<C-i>", action = "toggle_file_info" },
        { key = "<C-k>", action = "" },
      },
    },
  },
  filters = {
    custom = { "^.git$" },
  },
})
