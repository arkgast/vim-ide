local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "deno", "eslint_d", "eslint" },
  javascriptreact = { "deno", "eslint_d", "eslint" },
  typescript = { "deno", "eslint_d", "eslint" },
  typescriptreact = { "deno", "eslint_d", "eslint" },
  python = { "pyright" },
  rust = { "clippy" },
  lua = { "luacheck" },
  go = { "golangci-lint" },
}

-- Lint on enter and save for js/ts files
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    local lint = require("lint")
    local file = vim.fn.findfile("deno.lock", ".;")

    -- If deno.lock exists, only use deno linter
    if file ~= "" then
      pcall(function()
        lint.try_lint("deno")
      end)
    else
      -- Not a Deno project, try eslint
      pcall(function()
        lint.try_lint("eslint")
      end)
      pcall(function()
        lint.try_lint("eslint_d")
      end)
    end
  end,
})