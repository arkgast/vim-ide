local lspconfig = require('lspconfig')

local lsp = vim.lsp

local map = vim.keymap.set

local opts = { noremap = true, silent = true }
map("n", "<leader>e", vim.diagnostic.open_float, opts)
map("n", "<leader>l", vim.diagnostic.setloclist, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)

-- settings
vim.diagnostic.config({
  virtual_text = false
})

-- functions
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

-- setup lsp
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  map("n", "gD", lsp.buf.declaration, bufopts)
  map("n", "gd", lsp.buf.definition, bufopts)
  map("n", "gi", lsp.buf.implementation, bufopts)
  map("n", "<C-i>", lsp.buf.signature_help, bufopts)
  map("n", "<leader>i", lsp.buf.hover, bufopts)
  map("n", "<leader>f", lsp.buf.formatting, bufopts)
  map("n", "<leader>rn", lsp.buf.rename, bufopts)
  map("n", "<leader>r", ":Telescope lsp_references<CR>", bufopts)
  map("n", "<leader>oi", ":OrganizeImports<CR>", bufopts)
end

local capabilities = lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

lspconfig.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
}

lspconfig.solc.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
