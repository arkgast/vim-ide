local lspconfig = require("lspconfig")

local api = vim.api
local cmd = vim.cmd
local log = vim.log
local lsp = vim.lsp
local map = vim.keymap.set
local notify = vim.notify

-- functions
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { api.nvim_buf_get_name(0) },
    title = "",
  }
  lsp.buf.execute_command(params)
end

local async_formatting = function(bufnr)
  bufnr = bufnr or api.nvim_get_current_buf()

  lsp.buf_request(bufnr, "textDocument/formatting", lsp.util.make_formatting_params({}), function(err, res, ctx)
    if err then
      local err_msg = type(err) == "string" and err or err.message
      -- you can modify the log message / level (or ignore it completely)
      notify("formatting: " .. err_msg, log.levels.WARN)
      return
    end

    -- don't apply results if buffer is unloaded or has been modified
    if not api.nvim_buf_is_loaded(bufnr) or api.nvim_buf_get_option(bufnr, "modified") then
      return
    end

    if res then
      local client = lsp.get_client_by_id(ctx.client_id)
      lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
      api.nvim_buf_call(bufnr, function()
        cmd("silent noautocmd update")
      end)
    end
  end)
end

local augroup = api.nvim_create_augroup("LspFormatting", {})
local function null_ls_on_attach(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    api.nvim_create_autocmd("BufWritePost", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        async_formatting(bufnr)
      end,
    })
  end
end

-- setup lsp
local on_attach = function(client, bufnr)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gD", lsp.buf.declaration, bufopts)
  map("n", "gd", lsp.buf.definition, bufopts)
  map("n", "gi", lsp.buf.implementation, bufopts)
  map("n", "ga", lsp.buf.code_action)
  map("n", "<leader>i", lsp.buf.hover, bufopts)
  map("n", "<leader>=", lsp.buf.formatting, bufopts)
  map("n", "<leader>rn", lsp.buf.rename, bufopts)
  map("n", "<leader>oi", ":OrganizeImports<CR>", bufopts)

  null_ls_on_attach(client, bufnr)
end

local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
})

lspconfig.csharp_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.solc.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})
