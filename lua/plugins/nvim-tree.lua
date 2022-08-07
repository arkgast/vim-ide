require('nvim-tree').setup {
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  view = {
    number = true,
    relativenumber = true,
    width = 35,
    side = 'left',
  },
  filters = {
    custom = { '^.git$' },
  }
}
