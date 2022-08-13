local lspconfig = require('lspconfig')

local opts = { noremap = true, silent = true }
local lsp = vim.lsp

local map = vim.keymap.set

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gD", lsp.buf.declaration, bufopts)
  map("n", "gd", lsp.buf.definition, bufopts)
  map("n", "gi", lsp.buf.implementation, bufopts)
  map("n", "<C-i>", lsp.buf.signature_help, bufopts)
  map("n", "<leader>i", lsp.buf.hover, bufopts)
  map("n", "<leader>f", lsp.buf.formatting, bufopts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspconfig.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
