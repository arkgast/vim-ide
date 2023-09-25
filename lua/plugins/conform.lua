local conform = require('conform')

local slow_format_filetypes = {}

local function format_on_save(bufnr)
  if slow_format_filetypes[vim.bo[bufnr].filetype] then
    return
  end

  local function on_format(err)
    if err and err:match("timeout$") then
      slow_format_filetypes[vim.bo[bufnr].filetype] = true
    end
  end

  return { timeout_ms = 200, lsp_fallback = true }, on_format
end

local function format_after_save(bufnr)
  if not slow_format_filetypes[vim.bo[bufnr].filetype] then
    return
  end

  return { lsp_fallback = true }
end

conform.setup({
  format_on_save = format_on_save,
  format_after_save = format_after_save,
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    python = { "black" },
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    yaml = { "yamlfmt" },
  },
})
