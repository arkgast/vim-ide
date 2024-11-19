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
    local denoFile = vim.fn.findfile("deno.lock", ".;")
    if denoFile ~= "" then
      pcall(function()
        lint.try_lint("deno")
      end)
    end

    local packageFile = vim.fn.findfile("package.json", ".;")
    local yarnFile = vim.fn.findfile("yarn.json", ".;")
    if packageFile ~= "" or yarnFile ~= "" then
      local success = pcall(function()
        lint.try_lint("eslint")
      end)

      if not success then
        pcall(function()
          lint.try_lint("eslint_d")
        end)
      end
    end
  end,
})
