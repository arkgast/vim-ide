require("aerial").setup({
  backends = { "treesitter", "lsp", "markdown", "man" },
  layout = {
    max_width = { 40, 0.2 },
    min_width = 20,
    default_direction = "right",
    placement = "edge",
  },
  attach_mode = "global",
  filter_kind = {
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
  },
  show_guides = true,
  on_attach = function(bufnr)
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial prev" })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial next" })
  end,
})

vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle aerial outline" })
