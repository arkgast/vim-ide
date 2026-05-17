local wk = require("which-key")

wk.setup({
  preset = "modern",
  delay = 300,
  icons = {
    mappings = true,
  },
})

wk.add({
  { "<leader>A", group = "anchor/solana" },
  { "<leader>c", group = "crates" },
  { "<leader>r", group = "rust" },
  { "<leader>s", group = "swap" },
  { "<leader>S", group = "session" },
  { "<leader>p", group = "peek" },
  { "<leader>o", group = "organize" },
  { "<leader>t", group = "toggle" },
  { "<leader>h", group = "harpoon" },
  { "<leader>x", group = "trouble" },
  { "g", group = "goto" },
  { "]", group = "next" },
  { "[", group = "prev" },
})
