require("todo-comments").setup({
  signs = true,
  highlight = {
    multiline = false,
    pattern = [[.*<(KEYWORDS)\s*:]],
  },
})

local map = vim.keymap.set
map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo" })
map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Prev todo" })
map("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
