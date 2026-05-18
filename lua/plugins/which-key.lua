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
  { "<leader>H", group = "harpoon" },
  { "<leader>M", group = "markdown" },
  { "<leader>T", group = "test" },
  { "<leader>R", group = "refactor" },
  { "<leader>g", group = "git" },
  { "<leader>f", group = "find" },
  { "<leader>h", group = "hunks (gitsigns)" },
  { "<leader>x", group = "trouble" },
  { "g", group = "goto" },
  { "]", group = "next" },
  { "[", group = "prev" },
})
