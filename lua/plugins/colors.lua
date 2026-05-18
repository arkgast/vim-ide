require("nvim-highlight-colors").setup({
  render = "background",
  enable_named_colors = true,
  enable_tailwind = true,
  exclude_filetypes = { "lazy", "mason", "TelescopePrompt", "alpha" },
  virtual_symbol = "■",
})

vim.keymap.set("n", "<leader>tc", "<cmd>HighlightColors Toggle<cr>", { desc = "Toggle color preview" })
