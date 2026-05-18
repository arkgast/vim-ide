require("diffview").setup({
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
    },
  },
})

local map = vim.keymap.set
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diffview open" })
map("n", "<leader>gD", "<cmd>DiffviewClose<cr>", { desc = "Diffview close" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Repo history" })
