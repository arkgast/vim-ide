require('gitsigns').setup({
  signs = {
    add = { hl = 'GitSignsAdd' , text = '+', numhl='GitSignsAddNr' , linehl='GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 200,
  }
})
