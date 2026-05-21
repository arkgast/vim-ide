require("ts_context_commentstring").setup({
  enable_autocmd = false,
})
vim.g.skip_ts_context_commentstring_module = true

require("template-string").setup({
  filetypes = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "svelte",
    "python",
  },
  jsx_brackets = true,
  remove_template_string = true,
})
