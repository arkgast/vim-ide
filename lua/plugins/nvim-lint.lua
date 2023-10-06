local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d", "eslint" },
  javascriptreact = { "eslint_d", "eslint" },
  typescript = { "eslint_d", "eslint" },
  typescriptreact = { "eslint_d", "eslint" },
  python = { "pyright" },
  rust = { "clippy" },
  lua = { "luacheck" },
  go = { "golangci-lint" },
}

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	callback = function()
-- 		lint.try_lint()
-- 	end,
-- })

vim.cmd([[
  augroup Linting
      autocmd!
      autocmd BufWritePost,BufEnter *.js,*.jsx,*.ts,*.tsx lua require('lint').try_lint()
  augroup END
]])
