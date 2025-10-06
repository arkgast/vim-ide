require("avante").setup({
  provider = "ollama",
  providers = {
    ollama = {
      endpoint = "http://localhost:11434",
      model = "qwen2.5-coder:14b",
    },
  }
})
