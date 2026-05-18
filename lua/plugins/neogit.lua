require("neogit").setup({
  integrations = { diffview = true, telescope = true },
  graph_style = "unicode",
  disable_hint = true,
})

local map = vim.keymap.set
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit status" })
map("n", "<leader>gc", "<cmd>Neogit commit<cr>", { desc = "Neogit commit" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Branches" })
map("n", "<leader>gp", "<cmd>Neogit push<cr>", { desc = "Push" })
map("n", "<leader>gP", "<cmd>Neogit pull<cr>", { desc = "Pull" })
map("n", "<leader>gl", "<cmd>Neogit log<cr>", { desc = "Log" })
